package com.cos.security1.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cos.security1.entity.Copyright;

public interface CopyrightRepository extends JpaRepository<Copyright,Long>{
	
		public Optional<Copyright> findById(Long id);
		
		public Copyright findByPapername(String papername);
		
		public Copyright findByUniquenum(String uniquenum);
}
