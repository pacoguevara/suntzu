<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class User_model extends CI_Model {
	function getAll(){
		$this->db->select('user.*, rol.description');
		$this->db->join('rol', 'user.rol = rol.id');
		$q = $this->db->get('user');
		return $q->result();
	}
	function getById($id){
		$this->db->where('id', $id);
		$q = $this->db->get('user');
		return $q->result();
	}
	function insert($rol, $name, $last_name, $username, $password, $email){
		$data = array(
		   'rol' => $rol,
		   'name' => $name,
		   'last_name' => $last_name,
		   'username' => $username,
		   'password' => $password,
		   'email' => $email,
		);
		
		$this->db->insert('user', $data); 
		return $this->db->insert_id();
	}
	function update($id, $rol, $name, $last_name, $username, $password, $email){
		$data = array(
		   'rol' => $rol,
		   'name' => $name,
		   'last_name' => $last_name,
		   'username' => $username,
		   'password' => $password,
		   'email' => $email,
		);
		
		$this->db->where('id', $id);
		$this->db->update('user', $data); 
		return $this->db->insert_id();
	}
	function remove($id){
		$this->db->delete('user', array('id' => $id)); 
	}
	public function check($username, $password){
		$this->db->from('user');
		$this->db->where('username', $username);
		$this->db->where('password', $password);
		$q = $this->db->get();
		return $q->result();
	}
}
