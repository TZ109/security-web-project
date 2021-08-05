package com.cos.security1.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import com.cos.security1.entity.CostomerCenter;


public interface CustomerCenterRepository extends JpaRepository<CostomerCenter, Integer>{

	public CostomerCenter findById(Long id);
	
	public CostomerCenter findByUsername(String username);
	
	
	@Transactional
	public void deleteById(Long id);
}
