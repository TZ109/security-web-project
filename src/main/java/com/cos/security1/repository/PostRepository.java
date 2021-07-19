package com.cos.security1.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;


import com.cos.security1.entity.Post;



public interface PostRepository extends JpaRepository<Post, Integer>{

	public Optional<Post> findById(Long id);
	
	public Page<Post> findByPostTypeContaining(String postType, Pageable pageable);
}
