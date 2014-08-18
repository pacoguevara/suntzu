<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Scene_model extends CI_Model {
	function getAll(){
		$q = $this->db->get('scene');
		return $q->result();
	}
	function getById($id){
		$this->db->where('id', $id);
		$q = $this->db->get('scene');
		return $q->result();
	}
	function getByFloor($id){
		$this->db->select('scene.*, schedule.start, schedule.end, schedule.description, schedule');
		$this->db->where('floor', $id);
		$this->db->join('schedule', 'schedule.id = scene.schedule', "left");
		$q = $this->db->get('scene');
		return $q->result();
	}
	function insert($floor, $name){
		$data = array(
		   'floor' => $floor,
		   'name' => $name
		);
		
		$this->db->insert('scene', $data); 
		return $this->db->insert_id();
	}
	function updateSchedule($scene, $schedule){
		$data = array(
           'schedule' => $schedule
        );

        $this->db->where('id', $scene);
		$this->db->update('scene', $data); 
	}
	function remove($id){
		$this->db->where('id', $id);
		$this->db->delete('scene');
	}
}