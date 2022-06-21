#transformers,textrankr, konlpy 설치 필요
import torch
import sys,os,re
from transformers import PreTrainedTokenizerFast
from transformers import BartForConditionalGeneration
from konlpy.tag import Okt

from typing import List
from textrankr import TextRank
import numpy as np
import itertools
import nltk
import json
import csv

class OktTokenizer:
    okt: Okt = Okt()

    def __call__(self, text: str) -> List[str]:
        tokens: List[str] = self.okt.phrases(text)
        return tokens

mytokenizer: OktTokenizer = OktTokenizer()
textrank: TextRank = TextRank(mytokenizer)

def runTextRank(inputText, num):
    k: int = num  # num sentences in the resulting summary

    your_text_here = str(inputText)

    okt_summaries: List[str] = textrank.summarize(your_text_here, k, verbose=False)
        
    rank_output = ""
    for sentence in okt_summaries:
        sentence = str(sentence) + '. '
        rank_output = rank_output + sentence
    return rank_output

#nltk.download('punkt')
reg_section_name = r'\[.*?\]'
inc_section_list = ['발명의 명칭', '기술분야', '배경기술', '해결하려는 과제', '과제의 해결 수단', '발명의 효과']

def split_sentences(sentences): # str 타입 문장 list로 분할
  temp = ''
  temp_list = []
  sent_list = []
  result = []
  
  split_list = sentences.split('.')

  for s in split_list:
    if len(s) < 1:
      continue
    if s[-1] == '다':
      if len(temp_list) > 0:
        for t in temp_list:
          temp = ''.join(t)
        temp_list = []
        s = temp + s
      s = s + '.'
      sent_list.append(s)
    else:
      s = s + '.'
      temp_list.append(s)
  
  if len(temp_list) == 1:
    temp = temp_list[0]
    sent_list.append(temp[:-1])
  else:
    for t in temp_list:
      temp = ''.join(t)
    sent_list.append(temp)

  for s in sent_list:
    s = s.lstrip(' ')
    if len(s) > 1 and s != '.':
      result.append(s)
      
  return result

def get_sentences(data): # 특허에서 indc_section_list에 해당하는 항목 추출
  section_json = {}
  section_names = []
  section_contents = []

  is_section_name = True
  data = data.lstrip('\n')
  lines = data.split("\n")
  for line in lines:
    if is_section_name == True:
      if len(re.findall(reg_section_name, line)) == 1:
        section_names.append(line)
        is_section_name = False
    else:
      section_contents.append(line)
      is_section_name = True
  
  for i in range(len(section_names)):
    section_name = section_names[i].replace("[ ", "").replace(" ]", "").replace("[", "").replace("]", "")
    if section_name in inc_section_list:
      section_content_list = split_sentences(section_contents[i])
      section_json[section_name] = section_content_list

  return section_json

def prep_lex(data):
    patent = get_sentences(data)    
    original_article = []
    texts = []
    for i in ['기술분야', '해결하려는 과제', '과제의 해결 수단', '발명의 효과']:
        try:
            texts.append(' '.join(patent[i]))
        except:
            pass
    return original_article, texts

def tokenLen(input):
    return len(nltk.word_tokenize(input))

temp = os.path.isfile(sys.argv[1])
#temp = os.path.isfile('test.txt')
if temp :

    f = open(sys.argv[1],"r", encoding='UTF8')
    #f = open('test.txt',"r", encoding='UTF8')
    text = f.read();
    f.close();

    #텍스트가 빈값이면 종료
    if not text :
      print("파일이 없습니다.\n파일이 없습니다.")
      exit()

    else:
      #필요한 부분만 나눠 추출
      prep_text = prep_lex(text)

      #1차 요약
      textRankLen = 10
      while (tokenLen(runTextRank(text, textRankLen)) > 512):
          textRankLen = textRankLen - 1

      first_output = runTextRank(text, textRankLen)

      #KOBART 결과
      tokenizer = PreTrainedTokenizerFast.from_pretrained('digit82/kobart-summarization')
      model = BartForConditionalGeneration.from_pretrained('digit82/kobart-summarization')

      first_output  = first_output.replace('\n', ' ')

      raw_input_ids = tokenizer.encode(first_output)
      input_ids = [tokenizer.bos_token_id] + raw_input_ids + [tokenizer.eos_token_id]

      summary_ids = model.generate(torch.tensor([input_ids]),  num_beams=4,  max_length=512,  eos_token_id=1)
      KOBART_result = tokenizer.decode(summary_ids.squeeze().tolist(), skip_special_tokens=True)
      result = first_output +'\n' + KOBART_result
      print(result)
      

else : 
    print("파일이 없습니다.\n파일이 없습니다.")

exit();

