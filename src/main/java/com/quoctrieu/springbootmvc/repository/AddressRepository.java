package com.quoctrieu.springbootmvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.quoctrieu.springbootmvc.domain.Address;

@Repository
public interface AddressRepository extends JpaRepository<Address, Long> {

  @Query("select a from Address a where a.user.id = ?1 order by a.defaultAddress desc, a.updatedAt desc")
  List<Address> findByUser(Long userId);

  @Query("select a from Address a where a.user.id = ?1 order by a.defaultAddress desc, a.updatedAt desc")
  Address findDefaultByUser(Long userId);
}
