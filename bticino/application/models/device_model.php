<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Device_model extends CI_Model {
	function getAll(){
		$q = $this->db->get('device');
		return $q->result();
	}
	function getNames(){
		$this->db->select('name');
		$q = $this->db->get('device');
		return $q->result();
	}
	function getById($id){
		$this->db->where('id', $id);
		$q = $this->db->get('device');
		return $q->result();
	}
	function insert($serial, $name, $type){
		$data = array(
		   'serial' => $serial,
		   'name' => $name,
		   'type' => $type
		);
		
		$this->db->insert('device', $data); 
		return $this->db->insert_id();
	}
	function remove($id){
		$this->db->where('id', $id);
		$this->db->delete('device');
	}
}