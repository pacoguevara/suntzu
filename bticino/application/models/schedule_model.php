<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Schedule_model extends CI_Model {
	function getAll(){
		$this->db->where('id !=', '0');
		$q = $this->db->get('schedule');
		return $q->result();
	}
	function getEnabled(){
		$this->db->where('enabled', '1');
		$q = $this->db->get('schedule');
		return $q->result();
	}
	function getById($id){
		$this->db->where('id', $id);
		$q = $this->db->get('schedule');
		return $q->result();
	}
	function insert($description, $start, $end, $concurrent, $cronjobStart, $cronjobEnd){
		$data = array(
		    'description' => $description,
		    'start' => $start,
		    'end' => $end,
		    'concurrent' => $concurrent,
		    'cronjobStart' => $cronjobStart,
		    'cronjobEnd' => $cronjobEnd
		);
		
		$this->db->insert('schedule', $data); 
	}
	function remove($id){
		$this->db->delete('schedule', array('id' => $id)); 
	}
}