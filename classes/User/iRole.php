<?php

namespace User;

/*
* @author: Amin Ghadersohi
* @date: 2011-01-15
*
* The abstract class, aRole, implements the following methods, which can be subequenty overridden
* by the Role definition classes (e.g. UserRole, CenterDirectorRole, etc...)
* 
*/	

interface iRole
{

    // parameters: Parameters associated with a user and the role of interest
    //  @returns array
    public function getParameters();

	public function getAllQueryRealms($query_groupname);
} //iRole

?>