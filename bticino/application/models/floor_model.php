<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Floor_model extends CI_Model {
	function getAll(){
		$q = $this->db->get('floor');
		return $q->result();
	}
	function getById($id){
		$this->db->where('id', $id);
		$q = $this->db->get('floor');
		return $q->result();
	}
	function insert($name){
		$data = array(
		   'name' => $name
		);
		
		$this->db->insert('floor', $data); 
		return $this->db->insert_id();
	}
}