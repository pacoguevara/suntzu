<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Rol_model extends CI_Model {
	function getAll(){
		$q = $this->db->get('rol');
		return $q->result();
	}
	function getById($id){
		$this->db->where('id', $id);
		$q = $this->db->get('rol');
		return $q->result();
	}
}