<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Floor extends CI_Controller {
    public function __construct(){
        parent::__construct();
        $is_logged_in = $this->session->userdata('logged_in');
        if(!isset($is_logged_in) || $is_logged_in != true){
	        header('Location: '.base_url('index.php/session/access'));
        }       
    }
	public function show($id){
		$this->load->model('floor_model');
		$data['floor'] = $this->floor_model->getById($id)[0];
		$this->load->model('scene_model');
		$data['scenes'] = $this->scene_model->getByFloor($id);
		$this->general->head();
		$this->load->view('floor_home', $data);
		$this->load->view('common/tail');
	}
	public function saveFloor(){
		$name = $this->input->post('name');
		
		$this->load->model('floor_model');
		echo json_encode($this->floor_model->insert($name));
	}
	public function removeScene(){
		$id = $this->input->post('id');
		$this->load->model('scene_model');
		$this->scene_model->remove($id);
		
		$sceneFolderPath = getcwd()."/assets/scenes/".$id;
		shell_exec("sudo rm -rf ".$sceneFolderPath);
	}
}
