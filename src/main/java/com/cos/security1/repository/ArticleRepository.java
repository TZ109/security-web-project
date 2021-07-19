package com.cos.security1.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.repository.CrudRepository;

import com.cos.security1.entity.Article;


//관리대상 클래스, 대표값 타입(Long id)의 타입
public interface ArticleRepository extends JpaRepository<Article, Long>{

	//findBy 규칙-> Username문법
		//select * from user where username = 1? 파라미터에 들어온 내용을 넣어줌
		public Optional<Article> findById(Long id);
		
		public Article findByPapername(String papername);
		
		public Article findByUniquenum(String uniquenum);
}
