<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Device_scene_model extends CI_Model {
	function insert($device, $scene, $start, $end){
		$data = array(
		   'device' => $device,
		   'scene' => $scene,
		   'start' => $start,
		   'end' => $end
		);
		
		$this->db->insert('device_scene', $data);
	}
	function getByScene($scene){
		$this->db->where('scene', $scene);
		$q = $this->db->get('device_scene');
		return $q->result();
	}
}