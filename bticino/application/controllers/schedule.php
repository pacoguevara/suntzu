<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Schedule extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            if(!isset($is_logged_in) || $is_logged_in != true){
		header('Location: '.base_url('index.php/session/access'));
            }       
        }
	public function index(){
		$this->load->model('schedule_model');
		$data['schedules'] = $this->schedule_model->getAll();
		
		$this->general->head();
		$this->load->view('schedule_home', $data);
		$this->load->view('common/tail');
	}
	public function insert(){
		$description = $this->input->post('description');
		$start = $this->input->post('start');
		$end = $this->input->post('end');
		$concurrent = $this->input->post('concurrent');
		
		$cronStart = explode(":", $start);
		$cronjobStart = $cronStart[1] ." ". $cronStart[0] ." * * ".$concurrent;
		$cronEnd = explode(":", $end);
		$cronjobEnd = $cronEnd[1] ." ". $cronEnd[0] ." * * ".$concurrent;
		
		$this->load->model('schedule_model');
		$this->schedule_model->insert($description, $start, $end, $concurrent, $cronjobStart, $cronjobEnd);
	}
	
	public function remove(){
		$id = $this->input->post('id');
		
		$this->load->model('schedule_model');
		$this->schedule_model->remove($id);
	}
}
