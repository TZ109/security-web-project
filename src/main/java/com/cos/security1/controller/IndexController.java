package com.cos.security1.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.MessagingException;
import javax.print.attribute.standard.OrientationRequested;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;

import org.apache.catalina.connector.Response;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.metadata.DerbyTableMetaDataProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.SpringSecurityMessageSource;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedCookie;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.data.domain.Sort;

import com.cos.security1.UserRsa;

import com.cos.security1.config.auth.PrincipalDetails;
import com.cos.security1.entity.Article;
import com.cos.security1.entity.Copyright;
import com.cos.security1.entity.CostomerCenter;
import com.cos.security1.entity.Post;
import com.cos.security1.file.FileService;
import com.cos.security1.file.MD5Generator;
import com.cos.security1.model.MessageForm;
import com.cos.security1.model.User;
import com.cos.security1.pdfimage.Imagetest;
import com.cos.security1.repository.ArticleRepository;
import com.cos.security1.repository.CopyrightRepository;
import com.cos.security1.repository.PostRepository;
import com.cos.security1.repository.CustomerCenterRepository;
import com.cos.security1.repository.UserRepository;
import com.cos.security1.sendMail.CustomMailSender;
import com.cos.security1.sendMail.CustomMailSender2;
import com.cos.security1.sendMail.MailDto;
//import com.nimbusds.jose.jwk.gen.RSAKeyGenerator;


import java.security.InvalidKeyException;
//RSA
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.Principal;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPrivateKeySpec;
import java.security.spec.RSAPublicKeySpec;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Optional;
import java.util.UUID;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
//import org.apache.commons.codec.binary.Base64;
import java.util.Base64;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.nio.charset.*;



//인증이 안된 사용자들이 출입할 경로를 /auth/** 허용
//그냥 주소가 /이면 index.jsp허용

// /js /css /image 허

@ComponentScan
@Controller
public class IndexController {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired//스프링부트가 미리 생성한 객체를 자동연결
	private ArticleRepository articleRepository;
	
	@Autowired
	private CustomMailSender customMailSender;
	
	@Autowired
	private CustomMailSender2 customMailSender2;
	
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private CustomerCenterRepository costomerCenterRepository;
	
	
	@Autowired
    private FileService fileService;
	
	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private CopyrightRepository copyrightRepository;
	
	
	
	//localhost8090
	@RequestMapping(value = {"","/"}, method = RequestMethod.GET)//@GetMapping({"","/"})
	public String index()
	{
		//Mustache 기본폴더 src/main/resources
		//뷰리졸버 설정 templates(prefix), mustache(suffix) 생략가능 
		return "index";//src/main/resources/templates/index.mustache
	}
	
	
	@GetMapping("/popup")
	public String popUp()
	{
		return "popup";
	}
	
	@GetMapping("/user")
	public String userMain()
	{
		return "user/userForm";
	}
	/*
	@GetMapping("/user/sendRecv")
	public String userSendRecv(Model model) throws InvalidKeyException
	{
		
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserRsa rsa=new UserRsa();
		rsa.setPublicKeyByString(principal.getPublicKey());
		rsa.setPrivateKeyByString(principal.getPrivateKey());
		
		String tempRsa = "자바테스트";
		String sign=null;
		
		try {
			
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(rsa.getPublicKey(), RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			RSAPrivateKeySpec privateSpec = keyFactory.getKeySpec(rsa.getPrivateKey(), RSAPrivateKeySpec.class);
			String privateKeyModulus = privateSpec.getModulus().toString(16);
			String privateKeyExponent = privateSpec.getPrivateExponent().toString(16);
			
			
			
			model.addAttribute("Modulus","" + publicKeyModulus);
			model.addAttribute("Exponent","" + publicKeyExponent);
			

			//System.out.println("원문 : " +tempRsa);
			//sign = UserRsa.sign(tempRsa, principal.getPrivateKey());
			//System.out.println("사인 : "+sign);
			//System.out.println("사인확인 결과 : "+ UserRsa.verifySignarue(tempRsa,sign , "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEUQUHkPRu+b0cD51RKlMGbRFNDyMwWtsSv7kDjJARyOQ7tWC+E/62tNayKAJAMqEFFayel3FvhzGGcSSYD7JGrfeAPqzj13wrwVD5OzQclELP+VOmRis7G15S6EQpZRup7A2KKtTM3I8+"));
			
			 
		        
			
		}
		catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		//System.out.println(principal.getPublicKeyModulus()+"\n"+principal.getPublicKeyExponent());
		return "user/userSendRecv";
	}
	
	
	
	
	
	@PostMapping("/user/insertDB")//데이터 받을땐 postmapping
	public String insertDB(Article messageForm, HttpServletResponse response) throws  NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
				
			
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		UserRsa rsa=new UserRsa();
		rsa.setPrivateKeyByString(principal.getPrivateKey());
	//	System.out.println(""+principal.getPrivateKey()+"\n" +rsa.decrypt(messageForm.getY()));
		
		if(messageForm.getX().equals(rsa.decrypt(messageForm.getY())))
		{
			System.out.println("원문: "+messageForm.getX()+"\n복호화한 암호문 :" +rsa.decrypt(messageForm.getY()) + "\n일치합니다.");
			
			out.println("<script>alert('정상적으로 처리되었습니다.');</script>");
			out.flush();
		}
		//form -> entity
		//Article article = messageForm.toEntity();
		//repository에게 entity를 db에 저장하도록
		Article saved = articleRepository.save(messageForm);
		
		//받은 id값으로 db찾기
		//Optional<Article> optArticle = articleRepository.findById(messageForm.getZ());
		
		//System.out.println(saved.toString() + ", z="+messageForm.getZ());
		//System.out.println(optArticle.toString());
		
		//articleRepository.deleteById((long)1);//id1 삭제해줘요
		
		}catch(InvalidKeyException e)
		{
			System.out.println("잘못 된 키로 접근하였습니다.");
			out.println("<script>alert('잘못 된 키로 접근하였습니다.');</script>");
			out.println("<a href='/user/sendRecv'></a>");
			out.flush();
		}
		
	
		return "index";
	}
	*/

	@GetMapping("/admin")
	public @ResponseBody String admin()
	{
		return "admin";
	}
	
	@GetMapping("/manager")
	public @ResponseBody String manager()
	{
		return "manager";
	}
	
	/*
	@GetMapping("/showBoard/{id}")
	public List<Article> showBoard(@PathVariable("id") String id, Model model)
	{
		//System.out.println("id : " + id);
		
		//model.addAttribute("show", "show");
		//List<Post> postlist = postRepository.findAll();
		
		List<Article> postlist = articleRepository.findAll();
		model.addAttribute("secondpost","test");
		return postlist;
	}
	*/
	
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@GetMapping("/user/serial")
	public JSONObject searchSerial(@RequestParam("serial") String serial, Model model)
	{
		JSONObject res = new JSONObject();
		
		
		System.out.println("serial : "+serial);
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Article article = articleRepository.findByUniquenum(serial);
		int result=0;
		
		if(article != null)
		{
			if(article.getPeople1_email().equals(principal.getUsername()))
				result=1;
			
			else if(article.getPeople2_email().equals(principal.getUsername()))
				result=2;
			
			else if(article.getPeople3_email().equals(principal.getUsername()))
				result=3;
		}
		System.out.println("result : " +result);
		if(result!=0)
		{
			
			res.put("paper",article.getOrig_papername());
			res.put("filename", article.getOrig_name());
			switch(result)
			{
			case 3:
				res.put("per3",article.getPeople3_name());
			case 2:
				res.put("per2",article.getPeople2_name());
			case 1:
				res.put("per1",article.getPeople1_name());
			}
			
			return res;
		}
		
		
		
		return null;
	}
	
	//저작권 등록
	@GetMapping("/user/copyright")
	public String copyright()
	{
		return "user/copyright";
	}
	
	
	
	
	//전자서명 작성하는 곳으로 가기
	@GetMapping("/user/DocumentPage")
	public String documentPage()
	{

		
		
		return "user/DocumentPage";
	}
	
	//마이페이지
	@SuppressWarnings("unused")
	@GetMapping("/user/myPage")
	public String mypage(Model model)
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		List<Article> articleList = articleRepository.findAll();
		
		
		List<Article> ongoing= new Vector<Article>();
		List<Article> completed= new Vector<Article>();
		
		for(Article arti : articleList)
		{
			if(principal.getUsername().equals(arti.getPeople1_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed.add(arti);
				
				else
					ongoing.add(arti);
			}
			
			if(principal.getUsername().equals(arti.getPeople2_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed.add(arti);
				
				else
					ongoing.add(arti);
			}
			
			if(principal.getUsername().equals(arti.getPeople3_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed.add(arti);
				
				else
					ongoing.add(arti);
			}
				
		}
		
		model.addAttribute("name", principal.getRealname());
		model.addAttribute("email", principal.getUsername());
		model.addAttribute("signname", principal.getSignname());
		
		List<Copyright> copyrightList = copyrightRepository.findAll();
		
		List<Copyright> ongoing2 = new Vector<Copyright>();
		List<Copyright> completed2 = new Vector<Copyright>();
		
		for(Copyright arti : copyrightList)
		{
			if(principal.getUsername().equals(arti.getPeople1_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed2.add(arti);
				
				else
					ongoing2.add(arti);
			}
			
			
				
		}
		
		
		
		if(ongoing != null)
		{
			
			model.addAttribute("ongoing", ongoing);

		}
		if(completed != null)
		{
			model.addAttribute("completed", completed);

		}
		
		
		if(ongoing2 != null)
		{
			
			model.addAttribute("ongoing2", ongoing2);

		}
		if(completed2 != null)
		{
			model.addAttribute("completed2", completed2);

		}
		
		return "user/myPage";
	}
	
	@SuppressWarnings("unused")
	@PostMapping("/user/adminmyPage")
	public String adminmypage(Model model, String username)
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(!(principal!=null && principal.getRole().equals("ROLE_ADMIN")))
		{
			return "redirect:/";
		}
		
		
		
		User user = userRepository.findByUsername(username);
		
		List<Article> articleList = articleRepository.findAll();
		
		
		List<Article> ongoing= new Vector<Article>();
		List<Article> completed= new Vector<Article>();
		
		for(Article arti : articleList)
		{
			if(user.getUsername().equals(arti.getPeople1_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed.add(arti);
				
				else
					ongoing.add(arti);
			}
			
			if(user.getUsername().equals(arti.getPeople2_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed.add(arti);
				
				else
					ongoing.add(arti);
			}
			
			if(user.getUsername().equals(arti.getPeople3_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed.add(arti);
				
				else
					ongoing.add(arti);
			}
				
		}
		
		model.addAttribute("name", user.getRealname());
		model.addAttribute("email", user.getUsername());
		model.addAttribute("signname", user.getSignname());
		
		List<Copyright> copyrightList = copyrightRepository.findAll();
		
		List<Copyright> ongoing2 = new Vector<Copyright>();
		List<Copyright> completed2 = new Vector<Copyright>();
		
		for(Copyright arti : copyrightList)
		{
			if(user.getUsername().equals(arti.getPeople1_email()))
			{
				if(arti.getSign_count() == arti.getPeople_size())
					completed2.add(arti);
				
				else
					ongoing2.add(arti);
			}
			
			
				
		}
		
		
		if(ongoing != null)
		{
			
			model.addAttribute("ongoing", ongoing);

		}
		if(completed != null)
		{
			model.addAttribute("completed", completed);

		}
		
		
		if(ongoing2 != null)
		{
			
			model.addAttribute("ongoing2", ongoing2);

		}
		if(completed2 != null)
		{
			model.addAttribute("completed2", completed2);

		}
		
		return "user/myPage";
	}
	
	//마이페이지
		@SuppressWarnings("unused")
		@GetMapping("/user/adminPage")
		public String adminpage(Model model)
		{
			PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			
			if(!(principal!=null && principal.getRole().equals("ROLE_ADMIN")))
			{
				return "redirect:/";
			}
			
			
			List<User> userList = userRepository.findAll();
			
			
			
			
			model.addAttribute("name", principal.getRealname());
			model.addAttribute("email", principal.getUsername());
			model.addAttribute("signname", principal.getSignname());
			
			model.addAttribute("userList", userList);
			
			
			return "admin/adminPage";
		}
	
	
	
	


	@GetMapping("/user/editor")
	public String editor()
	{
		return "user/customerEditor";
	}
	
	@PostMapping("/user/editUpload")
	public String editUpload(Model model, String title, String textbody, String secret, String secretpassword, @RequestParam(value = "uploadfile",required = false) MultipartFile file, String checkfile, RedirectAttributes redirect)
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		CostomerCenter query;
		if(checkfile.equals("yes"))
			 {
				SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
				Date time = new Date();
				String time1 = format1.format(time);
				String servername = time1 + UUID.randomUUID().toString().replaceAll("-", "");
				String extension = FilenameUtils.getExtension(file.getOriginalFilename());
				
				query = new CostomerCenter( title, textbody, principal.getUsername(), principal.getRealname(),null, secret, secretpassword, file.getOriginalFilename(),servername + "."+ extension);
				fileService.fileCustomerCenterUpload(file, query.getServer_filename());
				//model.addAttribute("filename",file.getOriginalFilename());
			 }
		else
			query = new CostomerCenter( title, textbody, principal.getUsername(),principal.getRealname(), null, secret, secretpassword, null,null);
		
		
		costomerCenterRepository.save(query);
		
	
		
		System.out.println(query.getId()+"\n"+ title+"\n"+textbody);
		
		/*
		model.addAttribute("create_time",query.getCreateDate());
		model.addAttribute("user_realname", principal.getRealname());
		model.addAttribute("title", title);
		model.addAttribute("textbody",textbody);
		*/
		redirect.addAttribute("customerType",query.getId());
			
			
		return "redirect:/customerCenter";
	}
	
	//게시글 찾기
	@GetMapping("/customerCenter")
	public String editSearch(@PageableDefault(size=5, sort="id",direction = Sort.Direction.DESC) Pageable pageable, ModelMap model)
	{
		Page<CostomerCenter> pagelist = costomerCenterRepository.findAll(pageable);
		
		//CostomerCenter myQuery = costomerCenterRepository.findById(Long.parseLong(Id));
		//System.out.println(myQuery.getTitle()+"\n"+myQuery.getTextbody());
		
		//List<CostomerCenter> postlist = pagelist.getContent();
		
		int pageNumber=pagelist.getPageable().getPageNumber(); //현재페이지
		int totalPages=pagelist.getTotalPages(); //총 페이지 수. 검색에따라 10개면 10개..
		int pageBlock = 5; //블럭의 수 1, 2, 3, 4, 5
		int startBlockPage = ((pageNumber)/pageBlock)*pageBlock+1; //현재 페이지가 7이라면 1*5+1=6
		int endBlockPage = startBlockPage+pageBlock-1; //6+5-1=10. 6,7,8,9,10해서 10.
		endBlockPage= totalPages<endBlockPage? totalPages:endBlockPage;
		model.addAttribute("startBlockPage", startBlockPage);
		model.addAttribute("endBlockPage", endBlockPage);
		model.addAttribute("postlist", pagelist);
		
		return "customerCenter";
	}
	
	@PostMapping("/user/customerShowpost")
	public String showpost(@RequestParam("id") String id, Model model)
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		CostomerCenter costomerCenter = costomerCenterRepository.findById(Long.parseLong(id));
		
		//파일 존재할 때 
		if(costomerCenter.getFilename()!=null)
		{
			model.addAttribute("filename",costomerCenter.getFilename());
		}
		//답변이 있을 시
		if(costomerCenter.getAdmincomment()!=null)
		{
			model.addAttribute("admin_comment", costomerCenter.getAdmincomment());
		}
		model.addAttribute("post_id",costomerCenter.getId());
		model.addAttribute("create_time",costomerCenter.getCreateDate());
		model.addAttribute("user_realname", costomerCenter.getRealname());
		model.addAttribute("title", costomerCenter.getTitle());
		model.addAttribute("textbody",costomerCenter.getTextbody());
		return "user/customerShowpost";
	}
	
	@PostMapping("/user/deleteShowpost")
	public String deletepost(@RequestParam("id") String id, Model model)
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(principal!=null && principal.getRole().equals("ROLE_ADMIN"))
		{
			CostomerCenter cos = costomerCenterRepository.findById(Long.parseLong(id));
			
			if(cos.getServer_filename() != null && cos.getServer_filename().length() >= 1)
			{
				File delfile = new File(fileService.getUpCustomerCenter() + File.separator + cos.getServer_filename());
				delfile.delete();
				System.out.println("게시글 파일 삭제");
			}
			System.out.println("삭제할 게시글 id : "+id);
			costomerCenterRepository.deleteById(Long.parseLong(id));
			//파일 존재할 때 
			System.out.println("게시글 삭제");
			

		}
		
		
		return "redirect:/";
	}
	
	@GetMapping(value = "/customerDown/{id}")
    public ResponseEntity<InputStreamResource> getCustomer(@PathVariable("id") String id) throws FileNotFoundException, UnsupportedEncodingException {

		
		CostomerCenter costomerCenter = costomerCenterRepository.findById(Long.parseLong(id));
		System.out.println("파일명 : "+ costomerCenter.getFilename() );
		 String encordedFilename = URLEncoder.encode(costomerCenter.getFilename(),"UTF-8").replace("+", "%20");
        String filePath = fileService.getUpCustomerCenter() +File.separator +costomerCenter.getServer_filename();
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();      
        headers.add("content-disposition", "attachment;filename=" +encordedFilename);
        
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        if(id.indexOf(".pdf")!=-1)
		{
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(file.length())
                .contentType(MediaType.parseMediaType("application/pdf"))
                .body(resource);
		}
		else
		{
			return ResponseEntity.ok()
	                .headers(headers)
	                .contentLength(file.length())
	                .contentType(MediaType.parseMediaType("application/octet-stream"))
	                .body(resource);
		}
			
	}
	
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/checkCustomerPass", method= {RequestMethod.GET})
	public String checkCustomerPass(@RequestParam("id") String id, @RequestParam("pass") String pass)
	{
		//System.out.println("id : "+id + " , pass : "+pass);
		CostomerCenter costomerCenter = costomerCenterRepository.findById(Long.parseLong(id));
		String success="failed";
		
		
		if(costomerCenter.getSecretpassword()!=null && costomerCenter.getSecretpassword().equals(pass))
		{
			success="success";
			return success;
		}
		
		
		return success;
	}
	
	@ResponseBody
	@GetMapping("/user/customerComment")
	public int customerComment(@RequestParam(value="text", required=false) String text,@RequestParam("id") String id, RedirectAttributes redirectAttributes)
	{
		int result=0;
		
		if(id!=null)
		{
			redirectAttributes.addAttribute("admin_comment",text);
			
			CostomerCenter customerCenter = costomerCenterRepository.findById(Long.parseLong(id));
			customerCenter.setAdmincomment(text);
			costomerCenterRepository.save(customerCenter);
			System.out.println("text : "+text+"\nid : "+id);
			result=1;
		}
		
		return result;
	}
	
	
	
	
	//자료실
	@GetMapping("/board")
	public String board(@PageableDefault(size=5, sort="id",direction = Sort.Direction.DESC) Pageable pageable, ModelMap model, 
			@RequestParam(required = false, defaultValue = "-1")String postType)
	{
		Page<Post> pagelist = postRepository.findAll(pageable);
		
		
		if(postType!=null && postType!="-1")
		{
		  	switch(Integer.parseInt(postType))
		  	{
		  	case 1:
		  		pagelist = postRepository.findByPostTypeContaining("근로", pageable);
    			break;
    		case 2:
    			pagelist = postRepository.findByPostTypeContaining("구매", pageable);
    			break;
    		case 3:
    			pagelist = postRepository.findByPostTypeContaining("가맹", pageable);
    			break;
    		case 4:
    			pagelist = postRepository.findByPostTypeContaining("보험", pageable);
    			break;
    		case 5:
    			pagelist = postRepository.findByPostTypeContaining("금융", pageable);
    			break;
    		case 6:
    			pagelist = postRepository.findByPostTypeContaining("렌탈", pageable);
    			break;
    		case 7:
    			pagelist = postRepository.findByPostTypeContaining("기타", pageable);
		  	}
			//pagelist = articleRepository.find
		}
		
		//List<Post> postlist = pagelist.getContent();
		
		int pageNumber=pagelist.getPageable().getPageNumber(); //현재페이지
		int totalPages=pagelist.getTotalPages(); //총 페이지 수. 검색에따라 10개면 10개..
		int pageBlock = 5; //블럭의 수 1, 2, 3, 4, 5
		int startBlockPage = ((pageNumber)/pageBlock)*pageBlock+1; //현재 페이지가 7이라면 1*5+1=6
		int endBlockPage = startBlockPage+pageBlock-1; //6+5-1=10. 6,7,8,9,10해서 10.
		endBlockPage= totalPages<endBlockPage? totalPages:endBlockPage;
		model.addAttribute("startBlockPage", startBlockPage);
		model.addAttribute("endBlockPage", endBlockPage);
		model.addAttribute("postlist", pagelist);
		return "boardForm";
	}
	
	
	
	@GetMapping("/user/boardUpload")
	public String boardUpload()
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(principal!=null && principal.getRole().equals("ROLE_ADMIN"))
		{
			return "admin/boardUpload";
		}
		
		return "redirect:/";
	}
	
	
	@ResponseBody
	@GetMapping("/user/makeAdmin")
	public int makeAdmin(@RequestParam String target)
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		
		//요청한 사람이 관리자인지 확인
		if(principal!=null && principal.getRole().equals("ROLE_ADMIN"))
		{
			User user = userRepository.findByUsername(target);
			
			//해당 유저가 없음
			if(user == null)
			{
				return 0;
			}
			
			
			user.setRole("ROLE_ADMIN");
			userRepository.save(user);
			return 1;
		}
		
		return -1;
	}
	
	
	@PostMapping("/boardUp")
	public String boardUp(String postType, String special,String title,
			@RequestParam("hwp_file") MultipartFile hwp_file,@RequestParam("pdf_file") MultipartFile pdf_file)
	{
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
		Date time = new Date();
		String time1 = format1.format(time);
		String servername = time1 + UUID.randomUUID().toString().replaceAll("-", "");
		
		
		
		Post post = new Post(postType, special, title, servername+".pdf", servername+".hwp", pdf_file.getOriginalFilename(), hwp_file.getOriginalFilename());
		postRepository.save(post);
		
		
		
		
		fileService.fileBoardUpload(pdf_file, servername + ".pdf");
		fileService.fileBoardUpload(hwp_file, servername+".hwp");
		
		return "redirect:/board";
	}
	
	@GetMapping(value = "/boardDown/{id}")
    public ResponseEntity<InputStreamResource> getBoard(@PathVariable("id") String id) throws FileNotFoundException, UnsupportedEncodingException {

		Post temppost;
		System.out.println("파일명 : "+id );
		
		if(id==null)
			return null;
		
		
		
		
		
		String encordedFilename;
		String filePath;
		
		if(id.contains(".hwp"))
		{
			temppost = postRepository.findByServerhwp(id);
			filePath = fileService.getUpBoard() +File.separator +temppost.getServerhwp();
			 encordedFilename = URLEncoder.encode(temppost.getHwpLink(),"UTF-8").replace("+", "%20");
		}
		else
		{
			temppost = postRepository.findByServerpdf(id);
			filePath = fileService.getUpBoard() +File.separator +temppost.getServerpdf();
			encordedFilename = URLEncoder.encode(temppost.getPdfLink(),"UTF-8").replace("+", "%20");
		}
        
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();      
        headers.add("content-disposition", "attachment;filename=" +encordedFilename);
        
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        if(id.indexOf(".pdf")!=-1)
		{
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(file.length())
                .contentType(MediaType.parseMediaType("application/pdf"))
                .body(resource);
		}
		else
		{
			return ResponseEntity.ok()
	                .headers(headers)
	                .contentLength(file.length())
	                .contentType(MediaType.parseMediaType("application/octet-stream"))
	                .body(resource);
		}
			
	}
	//@RequestMapping(value = "/board/**/boardAdd")
	//public String boardAdd(HttpServletRequest req, ModelMap modelMap) {
	//	String jspPath = req.getRequestURI();
		//modelMap.put("boardSearchVO", boardSearchVO);
	//	return jspPath;
	//}

	
	
	//전자서명 만들기
	@PostMapping("/user/makeSign")
	public String makeSign(MessageForm message, @RequestParam("uploadFile") MultipartFile file, HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception
	{
	
		
		// redirectAttributes.addFlashAttribute("message",
	              //  "You successfully uploaded " + file.getOriginalFilename() + "!");
		
		 //db저장
		Article savedArticle = message.toEntity();
		
		System.out.println("첫번째 사인 좌표 x : "+message.getPer1()[0]+", y : "+message.getPer1()[1]);
		
		
		
		if(message.getPer1()!=null && message.getPer1().length==2)
		{
			savedArticle.setSign1_xpos(Integer.parseInt( message.getPer1()[0].replaceAll("[^0-9]", "")));
			savedArticle.setSign1_ypos(Integer.parseInt( message.getPer1()[1].replaceAll("[^0-9]", "")));
		}
		if(message.getPer2()!=null && message.getPer2().length==2)
		{
			savedArticle.setSign2_xpos(Integer.parseInt( message.getPer2()[0].replaceAll("[^0-9]", "")));
			savedArticle.setSign2_ypos(Integer.parseInt( message.getPer2()[1].replaceAll("[^0-9]", "")));
		}
		if(message.getPer3()!=null && message.getPer3().length==2)
		{
			savedArticle.setSign3_xpos(Integer.parseInt( message.getPer3()[0].replaceAll("[^0-9]", "")));
			savedArticle.setSign3_ypos(Integer.parseInt( message.getPer3()[1].replaceAll("[^0-9]", "")));
		}
		
		
		savedArticle.setSign_count(0);
		savedArticle.setPlain_text("계약서 원문");
		savedArticle.setFile_size(file.getSize());
		savedArticle.setOrig_name(file.getOriginalFilename());
		//서버에 저장된 파일이름 저장
		savedArticle.setSer_fileName(fileService.fileUpload(file, null));
		//경로저장
		savedArticle.setFile_path(fileService.getUpDownloadDir()+File.separator+savedArticle.getSer_fileName());
		
		
		
		
		articleRepository.save(savedArticle); 
		//System.out.println("계약서 생성 시간1 : "+savedArticle.getCreateDate().toString() );

		savedArticle.setUniquenum(savedArticle.getCreateDate().toString().replaceAll("[^0-9]", ""));
		//id_계약서이름으로 계약서 이름 지정
		String tempString = savedArticle.getPapername();
		savedArticle.setPapername(savedArticle.getId().toString()+"_"+tempString);
	
		//db에 존재하는 유저인지 판단
		boolean isValidUser=true;
	
		//articleRepository.deleteById(savedArticle.getId());
		
		//Article tempart = articleRepository.findByPapername(savedArticle.getPapername());
		//System.out.println("계약서 생성 시간2 : "+ tempart.getCreateDate());
		
		//유저가 db에 있는지 이메일을 통해 확인

		
		switch(savedArticle.getPeople_size())
		{
		case 3:
			User user3 = userRepository.findByUsername(savedArticle.getPeople3_email());
			if(user3==null)
			{
				isValidUser=false;
				break;
			}
			savedArticle.setPeople3_signname(user3.getSignname()); 
			System.out.println("사인 이름3 : "+user3.getSignname());
		
			
		case 2:
			User user2 = userRepository.findByUsername(savedArticle.getPeople2_email());
			if(user2==null)
			{
				isValidUser=false;
				break;
			}
			savedArticle.setPeople2_signname(user2.getSignname()); 
			System.out.println("사인 이름2 : "+user2.getSignname());
			
			
		case 1:
			User user = userRepository.findByUsername(savedArticle.getPeople1_email());
			if(user==null)
			{
				isValidUser=false;
				break;
			}
			
			savedArticle.setPeople1_signname(user.getSignname()); 
			System.out.println("사인 이름1 : "+user.getSignname());
			
		}
		
		if(isValidUser)
		{
			customMailSender.gmailSend(savedArticle,savedArticle.getPeople1_email(),null);
	
			
			//User user1 =userRepository.findByRealname(savedArticle.getPeople1_name());
			
			
			if(savedArticle.getPeople_size()>=2)
			{
				customMailSender.gmailSend(savedArticle,savedArticle.getPeople2_email(),null);
				
				
				//User user2 =userRepository.findByRealname(savedArticle.getPeople2_name());
				//savedArticle.setPeople2_signname(user2.getSignname()); 
			}
			 
			if(savedArticle.getPeople_size()==3)
			{
				customMailSender.gmailSend(savedArticle,savedArticle.getPeople3_email(),null);
	
				//User user3 =userRepository.findByRealname(savedArticle.getPeople3_name());
				//savedArticle.setPeople3_signname(user3.getSignname()); 
			}
			//Resource tempfile = fileService.loadFile(savedArticle.getSer_fileName());
			 
			 //System.out.println("찾은 파일 : "+tempfile.getFilename());
			 
			 
			articleRepository.save(savedArticle);
			//URI uriLocation = new URI("/");
		    //String basePath = rootPath + "/" + "single";
		   // String filePath = basePath + "/" + file.getOriginalFilename();
		    //File dest = new File(filePath);
		  //  file.transferTo(dest);
			////db에 저장
			//articleRepository.save(messageForm);
			//당연히 신청한 사람은 암호문 넣겠지
			
			//서명해야할 사람들에게 이메일로 전송
		}
		else
		{
			if(isValidUser==false)
				redirectAttributes.addFlashAttribute("isValidUser",-1);
			
			articleRepository.deleteById(savedArticle.getId());
			String referer = request.getHeader("Referer");
			return "redirect:"+referer;
		}
		
		return "redirect:/";//홈페이지로 보냄
	}
	
	@PostMapping("/user/makeSign2")
	public String makeSign2(MessageForm message, @RequestParam("uploadFile") MultipartFile file, HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception
	{
	
		
		// redirectAttributes.addFlashAttribute("message",
	              //  "You successfully uploaded " + file.getOriginalFilename() + "!");
		
		 //db저장
		Copyright savedArticle = message.toCopyright();
		
		System.out.println("첫번째 사인 좌표 x : "+message.getPer1()[0]+", y : "+message.getPer1()[1]);
		
		
		
		if(message.getPer1()!=null && message.getPer1().length==2)
		{
			savedArticle.setSign1_xpos(Integer.parseInt( message.getPer1()[0].replaceAll("[^0-9]", "")));
			savedArticle.setSign1_ypos(Integer.parseInt( message.getPer1()[1].replaceAll("[^0-9]", "")));
		}
		
		
		
		savedArticle.setSign_count(0);
		savedArticle.setPlain_text("계약서 원문");
		savedArticle.setFile_size(file.getSize());
		savedArticle.setOrig_name(file.getOriginalFilename());
		//서버에 저장된 파일이름 저장
		savedArticle.setSer_fileName(fileService.fileUpload(file, null));
		//경로저장
		savedArticle.setFile_path(fileService.getUpDownloadDir()+File.separator+savedArticle.getSer_fileName());
		

		User user = userRepository.findByUsername(savedArticle.getPeople1_email());
		if(user!=null)
		{
			savedArticle.setPeople1_signname(user.getSignname());
		}
		
		 
		
		
		
		copyrightRepository.save(savedArticle); 
		//System.out.println("계약서 생성 시간1 : "+savedArticle.getCreateDate().toString() );

		savedArticle.setUniquenum(savedArticle.getCreateDate().toString().replaceAll("[^0-9]", ""));
		//id_계약서이름으로 계약서 이름 지정
		String tempString = savedArticle.getPapername();
		savedArticle.setPapername(savedArticle.getId().toString()+"_"+tempString);
	
	
		
		customMailSender2.gmailSend(savedArticle,savedArticle.getPeople1_email(),null);
	
		copyrightRepository.save(savedArticle);
			
		
		
		
		return "redirect:/";//홈페이지로 보냄
	}
	
	
	
	@ResponseBody//페이지로 응답할 것임을 명시
	@PostMapping("/user/changesign")
	public int changesign(@RequestParam(value="file", required=true) MultipartFile file, @RequestParam(required=false) String title, @RequestParam(required=false) String create_time)
	{
		System.out.println("파일 이름 : "+ file.getSize());
		int result=0;
		
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		Article tempArt = articleRepository.findByPapername(title);

		User tempUser =  userRepository.findByUsername(principal.getUsername());
		
		if (tempUser != null ) {
			System.out.println("서명파일 : " + tempUser.getSignname());
			if (tempUser.getSignname() != null) {
				File deleteFile = new File(fileService.getUpDownloadDir() + File.separator + "userSign" + File.separator + principal.getSignname());
				
				if(deleteFile.delete())
				{
					System.out.println("서명파일 삭제완료");
				
				}
				
					
			}
			
			fileService.fileUpload(file, principal.getUsername()+"_sign.png");//tempUser.getSignname());
			
			//article db도 변경시켜야함
			if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))
			{
				
				if(tempArt.getPeople1_name().equals(principal.getRealname()))
				{
					tempArt.setPeople1_signname(principal.getUsername()+"_sign.png");
				}
				
				else if(tempArt.getPeople2_name().equals(principal.getRealname()))
				{
					tempArt.setPeople2_signname(principal.getUsername()+"_sign.png");
				}
				
				else if(tempArt.getPeople3_name().equals(principal.getRealname()))
				{
					tempArt.setPeople3_signname(principal.getUsername()+"_sign.png");
				}
				articleRepository.save(tempArt);
			}
			
			
			
			tempUser.setSignname(principal.getUsername()+"_sign.png");
			userRepository.save(tempUser);
		}

		
		
		return result;
	}
	
	@ResponseBody//페이지로 응답할 것임을 명시
	@PostMapping("/user/changesign2")
	public int changesign2(@RequestParam(value="file", required=true) MultipartFile file, @RequestParam(required=false) String title, @RequestParam(required=false) String create_time)
	{
		System.out.println("파일 이름 : "+ file.getSize());
		int result=0;
		
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		Copyright tempArt = copyrightRepository.findByPapername(title);

		User tempUser =  userRepository.findByUsername(principal.getUsername());
		
		if (tempUser != null ) {
			System.out.println("서명파일 : " + tempUser.getSignname());
			if (tempUser.getSignname() != null) {
				File deleteFile = new File(fileService.getUpDownloadDir() + File.separator + "userSign" + File.separator + principal.getSignname());
				
				if(deleteFile.delete())
				{
					System.out.println("서명파일 삭제완료");
				
				}
				
					
			}
			
			fileService.fileUpload(file, principal.getUsername()+"_sign.png");//tempUser.getSignname());
			
			//article db도 변경시켜야함
			if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))
			{
				
				if(tempArt.getPeople1_name().equals(principal.getRealname()))
				{
					tempArt.setPeople1_signname(principal.getUsername()+"_sign.png");
				}
			
				copyrightRepository.save(tempArt);
			}
			
			
			
			tempUser.setSignname(principal.getUsername()+"_sign.png");
			userRepository.save(tempUser);
		}

		
		
		return result;
	}
	
	
	@ResponseBody//페이지로 응답할 것임을 명시
	@GetMapping("/user/checksign")
	public int checkSign()
	{
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		

		User tempUser =  userRepository.findByUsername(principal.getUsername());
		
		if (tempUser != null && tempUser.getSignname() != null && tempUser.getSignname().length() >= 1) {
			File file =new File("input"+File.separator + "userSign"+File.separator+tempUser.getSignname());
			System.out.println("서명파일 확인 : " + file.getAbsolutePath());
			
			if(file.exists())
			{
				return 1;
			}
		}
		
		
		return -1;
	}
	
	
	
	
	//이메일로 타고온 전자서명 사인
	/*
	 * 1. 일단 db검색
	 * 2. db에 사인 넣음
	 * 3. 
	 */
	
	@GetMapping("/user/Documentcomplete")
	public String documentCompleteget()
	{
		
		return "redirect:/";
	}
	
	@PostMapping("/user/Documentcomplete")
	public String documentComplete(String title, Timestamp create_time, Model model )
	{
		Article tempArt = articleRepository.findByPapername(title);
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
		{
			if(tempArt.getOrig_name().contains(".pdf"))
				model.addAttribute("is_pdf","yes");
			
			
			model.addAttribute("real_paper_name", tempArt.getPapername().substring(tempArt.getPapername().indexOf("_")+1));
			
			model.addAttribute("paper_name", tempArt.getPapername());
			model.addAttribute("person_num", tempArt.getPeople_size());
			
			model.addAttribute("file_serverName", tempArt.getSer_fileName());
			model.addAttribute("orig_Name", tempArt.getOrig_name());
			//model.addAttribute("file_serPath", tempArt.getFile_path());
			model.addAttribute("create_date",tempArt.getCreateDate());
			
			model.addAttribute("person1_name",tempArt.getPeople1_name());
			model.addAttribute("person2_name",tempArt.getPeople2_name());
			model.addAttribute("person3_name",tempArt.getPeople3_name());
			
			model.addAttribute("person1_issign",tempArt.getPeople1_sign());
			model.addAttribute("person2_issign",tempArt.getPeople2_sign());
			model.addAttribute("person3_issign",tempArt.getPeople3_sign());
			
			model.addAttribute("person1_signtime",tempArt.getPeople1_time());
			model.addAttribute("person2_signtime",tempArt.getPeople2_time());
			model.addAttribute("person3_signtime",tempArt.getPeople3_time());
			
			model.addAttribute("person1_email",tempArt.getPeople1_email());
			model.addAttribute("person2_email",tempArt.getPeople2_email());
			model.addAttribute("person3_email",tempArt.getPeople3_email());
			
			model.addAttribute("uniquenum",tempArt.getUniquenum());
			model.addAttribute("peoplesize", tempArt.getPeople_size());
			model.addAttribute("signcount", tempArt.getSign_count());
			model.addAttribute("filesize", tempArt.getFile_size());
		}
		
		return "user/Documentcomplete";
	}
	
	@PostMapping("/user/Documentcomplete2")
	public String documentComplete2(String serialnum, Model model )
	{
		Article tempArt = articleRepository.findByUniquenum(serialnum);
		System.out.println("메인페이지에서 연결");
		if(tempArt!=null)//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
		{
			if(tempArt.getOrig_name().contains(".pdf"))
				model.addAttribute("is_pdf","yes");
			
			model.addAttribute("real_paper_name", tempArt.getPapername().substring(tempArt.getPapername().indexOf("_")+1));
			
			model.addAttribute("paper_name", tempArt.getPapername());
			model.addAttribute("person_num", tempArt.getPeople_size());
			
			model.addAttribute("file_serverName", tempArt.getSer_fileName());
			model.addAttribute("orig_Name", tempArt.getOrig_name());
			//model.addAttribute("file_serPath", tempArt.getFile_path());
			model.addAttribute("create_date",tempArt.getCreateDate());
			
			model.addAttribute("person1_name",tempArt.getPeople1_name());
			model.addAttribute("person2_name",tempArt.getPeople2_name());
			model.addAttribute("person3_name",tempArt.getPeople3_name());
			
			model.addAttribute("person1_issign",tempArt.getPeople1_sign());
			model.addAttribute("person2_issign",tempArt.getPeople2_sign());
			model.addAttribute("person3_issign",tempArt.getPeople3_sign());
			
			model.addAttribute("person1_signtime",tempArt.getPeople1_time());
			model.addAttribute("person2_signtime",tempArt.getPeople2_time());
			model.addAttribute("person3_signtime",tempArt.getPeople3_time());
			
			model.addAttribute("person1_email",tempArt.getPeople1_email());
			model.addAttribute("person2_email",tempArt.getPeople2_email());
			model.addAttribute("person3_email",tempArt.getPeople3_email());
			
			model.addAttribute("uniquenum",tempArt.getUniquenum());
			model.addAttribute("peoplesize", tempArt.getPeople_size());
			model.addAttribute("signcount", tempArt.getSign_count());
			model.addAttribute("filesize", tempArt.getFile_size());
		}
		
		return "user/Documentcomplete";
	}
	
	@PostMapping("/user/copyrightcomplete")
	public String copyrightComplete(String serialnum, Model model )
	{
		Copyright tempArt = copyrightRepository.findByUniquenum(serialnum);
		System.out.println("메인페이지에서 연결");
		if(tempArt!=null)//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
		{
			System.out.println("저작권 모델 추가");
			if(tempArt.getOrig_name().contains(".pdf"))
				model.addAttribute("is_pdf","yes");
			
			model.addAttribute("real_paper_name", tempArt.getPapername().substring(tempArt.getPapername().indexOf("_")+1));
			
			model.addAttribute("paper_name", tempArt.getPapername());
			model.addAttribute("person_num", tempArt.getPeople_size());
			
			model.addAttribute("file_serverName", tempArt.getSer_fileName());
			model.addAttribute("orig_Name", tempArt.getOrig_name());
			//model.addAttribute("file_serPath", tempArt.getFile_path());
			model.addAttribute("create_date",tempArt.getCreateDate());
			
			model.addAttribute("person1_name",tempArt.getPeople1_name());

			
			model.addAttribute("person1_issign",tempArt.getPeople1_sign());

			
			model.addAttribute("person1_signtime",tempArt.getPeople1_time());

			
			model.addAttribute("person1_email",tempArt.getPeople1_email());

			
			model.addAttribute("uniquenum",tempArt.getUniquenum());
			model.addAttribute("peoplesize", tempArt.getPeople_size());
			model.addAttribute("signcount", tempArt.getSign_count());
			model.addAttribute("filesize", tempArt.getFile_size());
		}
		
		return "user/Documentcomplete2";
	}
	
	@GetMapping("/user/DocumentcheckPage")
	public String docu( )
	{
		return "redirect:/";
	}
	
	
	//사인하러 가기
	@PostMapping("/user/DocumentcheckPage")
	public String documentCheckPage( String title, Timestamp create_time , Model model, HttpServletResponse response)//title에 계약서 이름이 담겨져 있음, create_time에 계약서 생성 시간 담김
	{
		//유저 정보 가져오기
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		//계약서 이름으로 db에서 계약서 정보 찾기
		Article tempArt = articleRepository.findByPapername(title);
		
		boolean signCheck = false;
		if(tempArt != null)
		{

			String one = "1";
			System.out.println("계약 인원수 : " + tempArt.getPeople_size());
			switch (tempArt.getPeople_size()) {

			case 1:
				if (one.equals(tempArt.getPeople1_sign())) {
					System.out.println("1인 싸인 완료");
					signCheck = true;

				}
				break;

			case 2:
				System.out
						.println("싸인여부 1 : " + tempArt.getPeople1_sign() + "  싸인 여부 2 : " + tempArt.getPeople2_sign());
				if (one.equals(tempArt.getPeople1_sign()) && one.equals(tempArt.getPeople2_sign())) {
					System.out.println("2인 싸인 완료");
					signCheck = true;
				}
				break;

			case 3:
				if (one.equals(tempArt.getPeople1_sign()) && one.equals(tempArt.getPeople2_sign())
						&& one.equals(tempArt.getPeople3_sign())) {
					System.out.println("3인 싸인 완료");
					signCheck = true;
				}
			}
		}
		
		//서명을 다 한 상태라면 메인화면으로 전송, 혹은 db 손상되어 데이터 유실 시
		if(tempArt==null || signCheck)
		{
			if(signCheck)
				model.addAttribute("sign_complete","complete");
			
			else if(tempArt==null)
				model.addAttribute("sign_null","null");
			
			return "temp";
		}
		
		
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{
				System.out.println("계약서 찾음");
				boolean foundName = false;
				
				if(tempArt.getPeople1_name().equals(principal.getRealname()))
					foundName=true;
				
				else if(tempArt.getPeople2_name().equals(principal.getRealname()))
					foundName=true;
				
				else if(tempArt.getPeople3_name().equals(principal.getRealname()))
					foundName=true;
				
				if(foundName)//계약서에 해당 이름이 있다면
				{
					Resource tempResource =null;
					try {
						//서버에 있는 파일 찾기
						tempResource = fileService.loadFile(tempArt.getSer_fileName());
						System.out.println("파일 찾기 성공 : " + tempResource.getFilename());
					} catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						System.out.println("파일을 찾을 수 없습니다.");
					}

					
					//파일 다운받기
					 
					/*
					String orgin_name = tempArt.getOrig_name();
					response.setContentType("application/octer-stream");
					response.setHeader("Content-Transfer-Encoding", "binary;");
					response.setHeader("Content-Disposition", "attachment; filename=\"" + orgin_name + "\"");
					/*
					try {
						OutputStream os = response.getOutputStream();
						FileInputStream fis = new FileInputStream(fileService.getUploadDir()+tempResource.getFilename());

						int count = 0;
						byte[] bytes = new byte[512];

						while ((count = fis.read(bytes)) != -1 ) {
							os.write(bytes, 0, count);
						}
				        
						fis.close();
						os.close();
					} catch (IOException ex) {
						System.out.println("FileNotFoundException");
					}*/
					
					if(tempArt.getOrig_name().contains(".pdf"))
						model.addAttribute("is_pdf","yes");
					
					
					model.addAttribute("paper_name", tempArt.getPapername());
					model.addAttribute("person_num", tempArt.getPeople_size());
					
					model.addAttribute("file_serverName", tempArt.getSer_fileName());
					model.addAttribute("orig_Name", tempArt.getOrig_name());
					//model.addAttribute("file_serPath", tempArt.getFile_path());
					model.addAttribute("create_date",tempArt.getCreateDate());
					
					model.addAttribute("person1_name",tempArt.getPeople1_name());
					model.addAttribute("person2_name",tempArt.getPeople2_name());
					model.addAttribute("person3_name",tempArt.getPeople3_name());
					
					model.addAttribute("person1_issign",tempArt.getPeople1_sign());
					model.addAttribute("person2_issign",tempArt.getPeople2_sign());
					model.addAttribute("person3_issign",tempArt.getPeople3_sign());
					
					return "user/DocumentcheckPage";
				}
					
				
			}
		//아니라면 홈페이지로 이동
		return "redirect:/";
	}
	
	
	@PostMapping("/user/DocumentcheckPage2")
	public String documentCheckPage2( String title, Timestamp create_time , Model model, HttpServletResponse response)//title에 계약서 이름이 담겨져 있음, create_time에 계약서 생성 시간 담김
	{
		//유저 정보 가져오기
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		//계약서 이름으로 db에서 계약서 정보 찾기
		Copyright tempArt = copyrightRepository.findByPapername(title);
		
		boolean signCheck = false;
		if(tempArt != null)
		{

			String one = "1";
			System.out.println("계약 인원수 : " + tempArt.getPeople_size());
			
				if (one.equals(tempArt.getPeople1_sign())) {
					System.out.println("1인 싸인 완료");
					signCheck = true;

				}

		}
		
		//서명을 다 한 상태라면 메인화면으로 전송, 혹은 db 손상되어 데이터 유실 시
		if(tempArt==null || signCheck)
		{
			if(signCheck)
				model.addAttribute("sign_complete","complete");
			
			else if(tempArt==null)
				model.addAttribute("sign_null","null");
			
			return "temp";
		}
		
		
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{
				System.out.println("계약서 찾음");
				boolean foundName = false;
				
				if(tempArt.getPeople1_name().equals(principal.getRealname()))
					foundName=true;
				
			
				if(foundName)//계약서에 해당 이름이 있다면
				{
					Resource tempResource =null;
					try {
						//서버에 있는 파일 찾기
						tempResource = fileService.loadFile(tempArt.getSer_fileName());
						System.out.println("파일 찾기 성공 : " + tempResource.getFilename());
					} catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						System.out.println("파일을 찾을 수 없습니다.");
					}

					
					
					if(tempArt.getOrig_name().contains(".pdf"))
						model.addAttribute("is_pdf","yes");
					
					
					model.addAttribute("paper_name", tempArt.getPapername());
					model.addAttribute("person_num", tempArt.getPeople_size());
					
					model.addAttribute("file_serverName", tempArt.getSer_fileName());
					model.addAttribute("orig_Name", tempArt.getOrig_name());
					//model.addAttribute("file_serPath", tempArt.getFile_path());
					model.addAttribute("create_date",tempArt.getCreateDate());
					
					model.addAttribute("person1_name",tempArt.getPeople1_name());
					
					model.addAttribute("person1_issign",tempArt.getPeople1_sign());
					
					
					return "user/DocumentcheckPage2";
				}
					
				
			}
		//아니라면 홈페이지로 이동
		return "redirect:/";
	}
	
	
	
	
	
	
	
	@GetMapping(value = "/image/{imagename}", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)//, produces = MediaType.IMAGE_JPEG_VALUE)//전송하는 스트림이 이미지임을 명시
	public ResponseEntity<byte[]> userSearch(@PathVariable("imagename") String imagename) throws IOException
	{ 
		System.out.println("서버에서 보낼 파일 경로 : "+fileService.getUpDownloadDir() +File.separator + imagename);//
		
		InputStream imageStream = new FileInputStream(fileService.getUpDownloadDir() +File.separator + imagename);//
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET, value = "/pdfdown/{id}")
	public ResponseEntity<byte[]> getPdf(@PathVariable("id") String id) throws IOException {
		System.out.println("서버에서 보낼 파일 경로 : "+fileService.getUpDownloadDir() +File.separator + id);//
	    final String filePath = fileService.getUpDownloadDir() +File.separator +id;
	    final byte[] pdfBytes = Files.readAllBytes(Paths.get(filePath));
	    final HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
	    headers.setContentType(MediaType.parseMediaType("application/pdf"));
	    headers.setContentDispositionFormData("attachment", null);
	    headers.setCacheControl("no-cache");
	    
	    ResponseEntity<byte[]> file = new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
	    return file;
	}
	
	@GetMapping(value = "/pdfview/{id}")
    public ResponseEntity<InputStreamResource> getTermsConditions(@PathVariable("id") String id) throws FileNotFoundException {

		System.out.println("파일명 : "+id );
		
        String filePath = fileService.getUpDownloadDir() +File.separator +id;
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();      
        headers.add("content-disposition", "inline;filename=" +id);
        
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        if(id.indexOf(".pdf")!=-1)
		{
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(file.length())
                .contentType(MediaType.parseMediaType("application/pdf"))
                .body(resource);
		}
		else
		{
			return ResponseEntity.ok()
	                .headers(headers)
	                .contentLength(file.length())
	                .contentType(MediaType.parseMediaType("application/octet-stream"))
	                .body(resource);
		}
			
	}
	
	//서명 결과물 보기
	@GetMapping(value = "/pdfreview/{id}")
    public ResponseEntity<InputStreamResource> getResult(@PathVariable("id") String id) throws FileNotFoundException {

		System.out.println("파일명 : "+id );
		
        String filePath = fileService.getUpResultDir() +File.separator +id;
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();      
        headers.add("content-disposition", "inline;filename=" +id);
        
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        if(id.indexOf(".pdf")!=-1)
		{
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(file.length())
                .contentType(MediaType.parseMediaType("application/pdf"))
                .body(resource);
		}
		else
		{
			return ResponseEntity.ok()
	                .headers(headers)
	                .contentLength(file.length())
	                .contentType(MediaType.parseMediaType("application/octet-stream"))
	                .body(resource);
		}
			
	}

	@GetMapping(value = "/showsign/{id}")
    public ResponseEntity<InputStreamResource> getSign(@PathVariable("id") String id) throws FileNotFoundException {

		System.out.println("파일명 : "+id );
		
        String filePath = fileService.getUpDownloadDir() +File.separator+"userSign"+File.separator +id;
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();      
        headers.add("content-disposition", "inline;filename=" +id);
        
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        if(id.indexOf(".pdf")!=-1)
		{
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(file.length())
                .contentType(MediaType.parseMediaType("application/pdf"))
                .body(resource);
		}
		else
		{
			return ResponseEntity.ok()
	                .headers(headers)
	                .contentLength(file.length())
	                .contentType(MediaType.parseMediaType("application/octet-stream"))
	                .body(resource);
		}
			
	}
	
	
	
	
	@GetMapping("/testing_viewer")
	public String testing_viewer() throws FileNotFoundException
	{
		String filePath = fileService.getUpDownloadDir() +File.separator +"testview.pdf";
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();      
        headers.add("content-disposition", "inline;filename=" +"testview.pdf");
        
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        
        
		return "testing_viewer";
	}
	
	@PostMapping("/user/sign")
	public String userSign(MessageForm message, String title, Timestamp create_time ) throws Exception
	{
		System.out.println("서명 합성하기");
		//유저 정보 가져오기
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		Article tempArt = articleRepository.findByPapername(title);
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{
				System.out.println("계약서 찾음");
				String sign=null;
				
				System.out.println("원문 : " +tempArt.getPlain_text());
				
				
				SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
				Date time = new Date();
				String time1 = format1.format(time);
				
				String one="1";
				
				if(tempArt.getPeople1_name().equals(principal.getRealname()) && tempArt.getPeople1_email().equals(principal.getUsername())  && !one.equals(tempArt.getPeople1_sign()))
				{
					sign = UserRsa.sign(tempArt.getPlain_text(), principal.getPrivateKey());
					tempArt.setPeople1_encrypt(sign);
					//System.out.println("사인1 : "+sign);
					System.out.println("사인1확인 결과 : "+ UserRsa.verifySignarue(tempArt.getPlain_text(),sign, principal.getPublicKey()));
					tempArt.setPeople1_sign("1");
					tempArt.setSign_count(tempArt.getSign_count()+1);
					tempArt.setPeople1_time(time1);
					//articleRepository.deleteById(tempArt.getId());
					articleRepository.save(tempArt);
				}
					
				
				else if(tempArt.getPeople2_name().equals(principal.getRealname()) && tempArt.getPeople2_email().equals(principal.getUsername()) && !one.equals(tempArt.getPeople2_sign()))
				{
					sign = UserRsa.sign(tempArt.getPlain_text(), principal.getPrivateKey());
					tempArt.setPeople2_encrypt(sign);
					//System.out.println("사인2 : "+sign);
					System.out.println("사인2확인 결과 : "+ UserRsa.verifySignarue(tempArt.getPlain_text(),sign, principal.getPublicKey()));
					tempArt.setPeople2_sign("1");
					tempArt.setSign_count(tempArt.getSign_count()+1);
					tempArt.setPeople2_time(time1);
					//articleRepository.deleteById(tempArt.getId());
					articleRepository.save(tempArt);
				}
				
				else if(tempArt.getPeople3_name().equals(principal.getRealname()) && tempArt.getPeople3_email().equals(principal.getUsername()) && !one.equals(tempArt.getPeople3_sign()))
				{
					sign = UserRsa.sign(tempArt.getPlain_text(), principal.getPrivateKey());
					tempArt.setPeople3_encrypt(sign);
					//System.out.println("사인3 : "+sign);
					System.out.println("사인3확인 결과 : "+ UserRsa.verifySignarue(tempArt.getPlain_text(),sign, principal.getPublicKey()));
					tempArt.setPeople3_sign("1");
					tempArt.setSign_count(tempArt.getSign_count()+1);
					tempArt.setPeople3_time(time1);
					//articleRepository.deleteById(tempArt.getId());
					articleRepository.save(tempArt);
				}
				
				//모두가 싸인을 완료했을 때
				boolean signCheck = false;
			
				System.out.println("계약 인원수 : "+tempArt.getPeople_size());
				switch(tempArt.getPeople_size())
				{
				
				case 1:
					if(one.equals(tempArt.getPeople1_sign()))
					{
						System.out.println("1인 싸인 완료");
						signCheck = true;
						
					}
					break;
					
				case 2:
					System.out.println("싸인여부 1 : "+tempArt.getPeople1_sign()+"  싸인 여부 2 : "+tempArt.getPeople2_sign());
					if(one.equals(tempArt.getPeople1_sign()) && one.equals(tempArt.getPeople2_sign()))
					{
						System.out.println("2인 싸인 완료");
						signCheck = true;
					}
					break;
					
				case 3:
					if(one.equals(tempArt.getPeople1_sign()) && one.equals(tempArt.getPeople2_sign()) && one.equals(tempArt.getPeople3_sign()))
					{
						System.out.println("3인 싸인 완료");
						signCheck = true;
					}
				}
				
				if(signCheck)
				{
					//봐야할 파일 주소와 계약서 자료 넘기기
					Imagetest.makeSignPage(fileService.getUpDownloadDir(), tempArt);	
					customMailSender.gmailSend(tempArt,tempArt.getPeople1_email(),fileService.getUpResultDir()+File.separator+tempArt.getSer_fileName());
					System.out.println("사인과 이미지 합성완료");
					if(tempArt.getPeople_size()>=2)
					{
						customMailSender.gmailSend(tempArt,tempArt.getPeople2_email(),"result"+File.separator+tempArt.getSer_fileName());
					}
					 
					if(tempArt.getPeople_size()==3)
					{
						customMailSender.gmailSend(tempArt,tempArt.getPeople3_email(),"result"+File.separator+tempArt.getSer_fileName());
					}
					
					
					
					
					
					
					//완료된 계약서 파일 해쉬
					InputStream imageStream = new FileInputStream(fileService.getUpResultDir() +File.separator + tempArt.getSer_fileName());//
					byte[] imageByteArray = IOUtils.toByteArray(imageStream);
					imageStream.close();
					
					MessageDigest md = MessageDigest.getInstance("SHA-256");
				    md.update(imageByteArray);
				    
				    
				    StringBuilder builder = new StringBuilder();
			        for (byte b: md.digest()) {
			          builder.append(String.format("%02x", b));
			        }
			        tempArt.setResult_hash(""+builder.toString());

				    System.out.println("해쉬값 : "+tempArt.getResult_hash());
				    articleRepository.save(tempArt);

					
				}

			}
		return "redirect:/user/myPage";//홈페이지로 보냄
	}
	
	@PostMapping("/user/sign2")
	public String userSign2(MessageForm message, String title, Timestamp create_time ) throws Exception
	{
		System.out.println("서명 합성하기");
		//유저 정보 가져오기
		PrincipalDetails principal= (PrincipalDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		Copyright tempArt = copyrightRepository.findByPapername(title);
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{
				System.out.println("계약서 찾음");
				String sign=null;
				
				System.out.println("원문 : " +tempArt.getPlain_text());
				
				
				SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
				Date time = new Date();
				String time1 = format1.format(time);
				
				String one="1";
				
				if(tempArt.getPeople1_name().equals(principal.getRealname()) && tempArt.getPeople1_email().equals(principal.getUsername())  && !one.equals(tempArt.getPeople1_sign()))
				{
					sign = UserRsa.sign(tempArt.getPlain_text(), principal.getPrivateKey());
					tempArt.setPeople1_encrypt(sign);
					//System.out.println("사인1 : "+sign);
					System.out.println("사인1확인 결과 : "+ UserRsa.verifySignarue(tempArt.getPlain_text(),sign, principal.getPublicKey()));
					tempArt.setPeople1_sign("1");
					tempArt.setSign_count(tempArt.getSign_count()+1);
					tempArt.setPeople1_time(time1);
					//articleRepository.deleteById(tempArt.getId());
					copyrightRepository.save(tempArt);
				}

				//모두가 싸인을 완료했을 때
				boolean signCheck = false;
			
				System.out.println("계약 인원수 : "+tempArt.getPeople_size());
				
					if(one.equals(tempArt.getPeople1_sign()))
					{
						System.out.println("1인 싸인 완료");
						signCheck = true;
						
					}
					
					
				
				
				
				if(signCheck)
				{
					//봐야할 파일 주소와 계약서 자료 넘기기
					Imagetest.makeSignPage2(fileService.getUpDownloadDir(), tempArt);	
					customMailSender2.gmailSend(tempArt,tempArt.getPeople1_email(),fileService.getUpResultDir()+File.separator+tempArt.getSer_fileName());
					System.out.println("사인과 이미지 합성완료");
					
					
					
					
					
					
					//완료된 계약서 파일 해쉬
					InputStream imageStream = new FileInputStream(fileService.getUpResultDir() +File.separator + tempArt.getSer_fileName());//
					byte[] imageByteArray = IOUtils.toByteArray(imageStream);
					imageStream.close();
					
					MessageDigest md = MessageDigest.getInstance("SHA-256");
				    md.update(imageByteArray);
				    
				    
				    StringBuilder builder = new StringBuilder();
			        for (byte b: md.digest()) {
			          builder.append(String.format("%02x", b));
			        }
			        tempArt.setResult_hash(""+builder.toString());

				    System.out.println("해쉬값 : "+tempArt.getResult_hash());
				    copyrightRepository.save(tempArt);

					
				}

			}
		return "redirect:/user/myPage";//홈페이지로 보냄
	}
	
	//input파일안 계약서 다운로드
	@PostMapping("/user/signedDownload")
	public void signedDownload(String title,Timestamp create_time , HttpServletResponse response)
	{
		Article tempArt = articleRepository.findByPapername(title);
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{

			 BufferedOutputStream out = null;
		     InputStream in = null;
			
		     System.out.println("서명 이전 다운로드 : "+tempArt.getOrig_name());
			 try {
				 //한글제목은 encoding해서 보내줘야함
				 String encordedFilename = URLEncoder.encode(tempArt.getOrig_name(),"UTF-8").replace("+", "%20");
				 response.setHeader("Content-Disposition",   "attachment;filename=" + encordedFilename + ";filename*= UTF-8''" + encordedFilename);
				 response.setContentType("image/*");
				 //response.setHeader("Content-Disposition", "inline;filename="+tempArt.getSer_fileName());
		            File file = new File(fileService.getUpDownloadDir()+File.separator+tempArt.getSer_fileName());//upDownloadDir로 바꿀 것
		            if(file.exists()) {
		                in = new FileInputStream(file);
		                out = new BufferedOutputStream(response.getOutputStream());
		                int len;
		                byte[] buf = new byte[1024];
		                while ((len = in.read(buf)) > 0) {
		                    out.write(buf, 0, len);
		                }
		            }
		            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		        	try {
		            if(out != null) { out.flush();}
		            if(out != null) { out.close();}
		            if(out != null) { in.close();}
		        	}catch(Exception e)
		        	{
		        		e.printStackTrace();
		        	}
		        }
		 
		}

	}
	
	
	@PostMapping("/user/signedDownload2")
	public void signedDownload2(String title,Timestamp create_time , HttpServletResponse response)
	{
		Copyright tempArt = copyrightRepository.findByPapername(title);
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{

			 BufferedOutputStream out = null;
		     InputStream in = null;
			
		     System.out.println("서명 이전 다운로드 : "+tempArt.getOrig_name());
			 try {
				 //한글제목은 encoding해서 보내줘야함
				 String encordedFilename = URLEncoder.encode(tempArt.getOrig_name(),"UTF-8").replace("+", "%20");
				 response.setHeader("Content-Disposition",   "attachment;filename=" + encordedFilename + ";filename*= UTF-8''" + encordedFilename);
				 response.setContentType("image/*");
				 //response.setHeader("Content-Disposition", "inline;filename="+tempArt.getSer_fileName());
		            File file = new File(fileService.getUpDownloadDir()+File.separator+tempArt.getSer_fileName());//upDownloadDir로 바꿀 것
		            if(file.exists()) {
		                in = new FileInputStream(file);
		                out = new BufferedOutputStream(response.getOutputStream());
		                int len;
		                byte[] buf = new byte[1024];
		                while ((len = in.read(buf)) > 0) {
		                    out.write(buf, 0, len);
		                }
		            }
		            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		        	try {
		            if(out != null) { out.flush();}
		            if(out != null) { out.close();}
		            if(out != null) { in.close();}
		        	}catch(Exception e)
		        	{
		        		e.printStackTrace();
		        	}
		        }
		 
		}

	}
	
	//사인 완료된 result 파일안의 계약서 다운로드
	@PostMapping("/user/completesignedDownload")
	public void completesignedDownload(String title,Timestamp create_time , HttpServletResponse response)
	{
		Article tempArt = articleRepository.findByPapername(title);
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{

			 BufferedOutputStream out = null;
		     InputStream in = null;
			
		     System.out.println("서명 이전 다운로드 : "+tempArt.getOrig_name());
			 try {
				 //한글제목은 encoding해서 보내줘야함
				 String encordedFilename = URLEncoder.encode(tempArt.getOrig_name(),"UTF-8").replace("+", "%20");
				 response.setHeader("Content-Disposition",   "attachment;filename=" + encordedFilename + ";filename*= UTF-8''" + encordedFilename);
				 response.setContentType("image/*");
				 //response.setHeader("Content-Disposition", "inline;filename="+tempArt.getSer_fileName());
		            File file = new File(fileService.getUpResultDir()+File.separator+tempArt.getSer_fileName());//upDownloadDir로 바꿀 것
		            if(file.exists()) {
		                in = new FileInputStream(file);
		                out = new BufferedOutputStream(response.getOutputStream());
		                int len;
		                byte[] buf = new byte[1024];
		                while ((len = in.read(buf)) > 0) {
		                    out.write(buf, 0, len);
		                }
		            }
		            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		        	try {
		            if(out != null) { out.flush();}
		            if(out != null) { out.close();}
		            if(out != null) { in.close();}
		        	}catch(Exception e)
		        	{
		        		e.printStackTrace();
		        	}
		        }
		 
		}

	}
	
	@PostMapping("/user/completesignedDownload2")
	public void completesignedDownload2(String title,Timestamp create_time , HttpServletResponse response)
	{
		Copyright tempArt = copyrightRepository.findByPapername(title);
		
		
		if(tempArt!=null && tempArt.getCreateDate().toString().equals(create_time.toString()))//해당 이름의 계약서가 있고, 계약서 생성시기도 일치할 때 
			{

			 BufferedOutputStream out = null;
		     InputStream in = null;
			
		     System.out.println("서명 이전 다운로드 : "+tempArt.getOrig_name());
			 try {
				 //한글제목은 encoding해서 보내줘야함
				 String encordedFilename = URLEncoder.encode(tempArt.getOrig_name(),"UTF-8").replace("+", "%20");
				 response.setHeader("Content-Disposition",   "attachment;filename=" + encordedFilename + ";filename*= UTF-8''" + encordedFilename);
				 response.setContentType("image/*");
				 //response.setHeader("Content-Disposition", "inline;filename="+tempArt.getSer_fileName());
		            File file = new File(fileService.getUpResultDir()+File.separator+tempArt.getSer_fileName());//upDownloadDir로 바꿀 것
		            if(file.exists()) {
		                in = new FileInputStream(file);
		                out = new BufferedOutputStream(response.getOutputStream());
		                int len;
		                byte[] buf = new byte[1024];
		                while ((len = in.read(buf)) > 0) {
		                    out.write(buf, 0, len);
		                }
		            }
		            
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		        	try {
		            if(out != null) { out.flush();}
		            if(out != null) { out.close();}
		            if(out != null) { in.close();}
		        	}catch(Exception e)
		        	{
		        		e.printStackTrace();
		        	}
		        }
		 
		}

	}
	

	//메일 보내기 테스트
    @RequestMapping(value = "/mail",  method= {RequestMethod.POST})
    public String execMail(MailDto mailDto) {
    	
    	customMailSender.gmailSend(null,null,null);
    	
    	return "index";
    }
	
    
    
    
    
    
	
	//SecurityConfig 작성후엔 스프링 시큐리티가 자동으로 안잡아줌
    @RequestMapping(value = {"/loginForm"}, method = RequestMethod.GET)
	public String loginform(HttpServletRequest req)
	{
		//String referer = req.getHeader("Referer");
		//req.getSession().setAttribute("prevPage", referer);
		return "loginForm";
	}
	
	@PostMapping("/findUserId")
	public String findUserId()
	{
		return "redirect:/joinForm";
		
	}
	
	
	
	@RequestMapping(value = {"/joinForm"}, method = RequestMethod.GET)
	public String joinForm(Model model)
	{
		//model.addAttribute("checkName","");
			//customMailSender.sendMail();

		
		return "joinFormRetry";
	}
	
	
	
	//아이디 중복체크 RedirectAttributes는 redirect: 리턴 시 쓸 수 있음
	@RequestMapping(value = {"/dupname"}, method = RequestMethod.POST)
	public String dupname(String checkname, HttpServletRequest request, RedirectAttributes redirectAttributes)
	{
		//이메일 형식인지 검사
		boolean err = false;
		String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(checkname);
		if(m.matches()) { err = true; }
		
		//이메일 형식일 경우
		if(err)
				
			//해당 아이디가 없다면,
			//빈 값이 아닐 경우
			if(checkname.replaceAll("(^\\p{Z}+|\\p{Z}+$)", "")!=null && userRepository.findByUsername(checkname)==null)
				{
				System.out.println("해당이름 사용가능 : "+checkname.replaceAll("(^\\p{Z}+|\\p{Z}+$)", "")+", "+request.getAttribute("checkName"));
				
				redirectAttributes.addFlashAttribute("checkSuccess",1);  
				}
			else
				{

				redirectAttributes.addFlashAttribute("checkSuccess",-1); 
				}
	
		else
		{

			redirectAttributes.addFlashAttribute("checkSuccess",-2); 
		}
		redirectAttributes.addFlashAttribute("checkName",checkname);
		String referer = request.getHeader("Referer");
		return "redirect:"+referer;
	}
	
	 @ResponseBody
	    @RequestMapping(value="/idCheck", method=RequestMethod.POST)
	    public int IdCheck(@RequestBody String memberId) throws Exception {
		
			boolean err = false;
			String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(memberId);
			
			if (m.matches()) {
				err = true;
			}

			int count = -1;
			
			if(err)
			{
				if (userRepository.findByUsername(memberId) == null) {
					count = 0;
				}

				else {
					count = 1;
				}
			}
			return count; 
	    }

	
	
	@PostMapping("/join")//GetMapping이 post지원 안해준다해서
	public String join(User user, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		//String test="평문";
			user.setRole("ROLE_USER");
			//userRepository.save(user);// 시큐리티로 로그인 불가=>패스워드 암호화가 안됨
			String rawPassword = user.getPassword();
			String encPassword = bCryptPasswordEncoder.encode(rawPassword);
			user.setPassword(encPassword);
		
			
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			KeyPair keyPair = generator.generateKeyPair();
			
			PublicKey publickey = keyPair.getPublic();
			PrivateKey privatekey = keyPair.getPrivate();
			
			
			
			user.setPrivateKey(Base64.getEncoder().encodeToString(privatekey.getEncoded()));
			user.setPublicKey(Base64.getEncoder().encodeToString(publickey.getEncoded()));
	
			
			//String page ="original";
			//System.out.println(user.getUsername() + " " + user.getEmail() + ",\n"+user.getPrivateKey());
			//System.out.println("원문: "+test);
			//System.out.println("암호문: "+user.encrypt(test));
			
			
			
			//user.setSignname(user.getUsername()+file.getOriginalFilename());
			
			userRepository.save(user);//회원가입됨
			

			
			//사인 이미지 업로드
			//fileService.fileUpload(file,user.getSignname());
	
			
			return "redirect:/loginForm";//redirect는 loginForm함수 호출
		
	}
	


	/*
	@GetMapping("/joinProc")
	public @ResponseBody String joinProc()
	{
		return "회원가입 완료됨";
	}
	*/
}
