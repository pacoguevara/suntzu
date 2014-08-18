<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Device extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            if(!isset($is_logged_in) || $is_logged_in != true){
	            header('Location: '.base_url('index.php/session/access'));
            }       
        }
	public function all(){
		$this->load->model('device_model');
		$data['devices'] = $this->device_model->getAll();
		
		$this->general->head();
		$this->load->view('device_all', $data);
		$this->load->view('common/tail');
	}
	public function turnDevice(){
		$operation = $this->input->post('operation');
		$device = $this->input->post('device');
		shell_exec('echo "*1*'.$operation.'*'.$device.'#9##" > /dev/ttyUSB0');
	}
	public function dimDevice(){
		$level = $this->input->post('level');
		$device = $this->input->post('device');
		shell_exec('echo "*1*'.$level.'*'.$device.'#9##" > /dev/ttyUSB0');
	}
	public function nameDevice(){
		$this->load->model('device_model');
		$data = $this->device_model->getNames();
		echo json_encode($data);
	}
	public function remove(){
		$id = $this->input->post('id');
		$this->load->model('device_model');
		$this->device_model->remove($id);
	}
}
