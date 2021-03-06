package com.cos.security1.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;


import com.cos.security1.entity.Post;



public interface PostRepository extends JpaRepository<Post, Integer>{

	public Post findById(Long id);
	
	public Post findByServerpdf(String serverpdf);
	
	public Post findByServerhwp(String serverhwp);
	
	public Page<Post> findByPostTypeContaining(String postType, Pageable pageable);
}
