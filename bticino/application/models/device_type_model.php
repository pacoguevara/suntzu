<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Device_type_model extends CI_Model {
	function all(){
		$q = $this->db->get('device_type');
		return $q->result();
	}
}