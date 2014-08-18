<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Scene extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            if(!isset($is_logged_in) || $is_logged_in != true){
	            header('Location: '.base_url('index.php/session/access'));
            }       
        }
	public function home(){
		$this->load->model('schedule_model');
		$data['schedules'] = $this->schedule_model->getEnabled();
		$this->load->model('device_model');
		$data['devices'] = $this->device_model->getAll();
		
		$this->general->head();
		$this->load->view('scene_home', $data);
		$this->load->view('common/tail');
	}
	public function saveScene(){
		$floor = $this->input->post('floor');
		$name = $this->input->post('name');
		
		$this->load->model('scene_model');
		echo json_encode($this->scene_model->insert($floor, $name));
	}
	public function updateSchedule(){
		$scene = $this->input->post('scene');
		$schedule = $this->input->post('schedule');
		
		$this->load->model('scene_model');
		$this->scene_model->updateSchedule($scene, $schedule);
	}
	public function addDevice(){
		$scene = $this->input->post('scene');
		$device = $this->input->post('device');
		$serial = $this->input->post('serial');
		$state = $this->input->post('state');
		$type = $this->input->post('type');
		
		$start = "*1*".$state."*".$serial."#9##";
		if($type == 's'){
			$state = 1 - $state;
		}else{
			$state = 0;
		}
		$end = "*1*".$state."*".$serial."#9##";
		
		$this->load->model('device_scene_model');
		$this->device_scene_model->insert($device, $scene, $start, $end);
	}
	public function on(){
		$this->general->on();
	}
	public function off(){
		$this->general->off();
	}
	public function start(){
		$scene = $this->input->post("scene");
		$this->load->model('device_scene_model');
		$response = $this->device_scene_model->getByScene($scene);
		foreach($response as $r){
			$this->general->generic($r->start);	
		}
	}
	public function end(){
		$scene = $this->input->post("scene");
		$this->load->model('device_scene_model');
		$response = $this->device_scene_model->getByScene($scene);
		foreach($response as $r){
			$this->general->generic($r->end);	
		}
	}
	public function saveConcurrent(){
		$sceneP = $this->input->post('sceneP');
		$this->load->model('scene_model');
		$scene = $this->scene_model->getById($sceneP);
		$scene = $scene[0];
		$schedule_id = $scene->schedule;
		$this->load->model('schedule_model');
		$schedule = $this->schedule_model->getById($schedule_id);
		$schedule = $schedule[0];

		$sceneFolderPath = getcwd()."/assets/scenes/".$sceneP;
		shell_exec("sudo mkdir ".$sceneFolderPath);
		shell_exec("sudo chmod 777 ". $sceneFolderPath);
		shell_exec("sudo touch ".$sceneFolderPath."/start.sh ".$sceneFolderPath."/end.sh");
		shell_exec("sudo chmod 777 ".$sceneFolderPath."/start.sh ".$sceneFolderPath."/end.sh");
		
		$this->load->model('device_scene_model');
		$response = $this->device_scene_model->getByScene($sceneP);
		
		shell_exec('sudo echo "#!/bin/bash"	 > '.$sceneFolderPath.'/start.sh');
		foreach($response as $r){
			$myHC = 'sudo echo "'.$r->start.'" > /dev/ttyUSB0';
			shell_exec('sudo echo "'.$myHC.'" >> '.$sceneFolderPath.'/start.sh');
		}
		shell_exec('(crontab -l ; echo "'.$schedule->cronjobStart.' '.$sceneFolderPath.'/start.sh'.'") | crontab -');
		
		shell_exec('sudo echo "#!/bin/bash" > '.$sceneFolderPath.'/end.sh');
		foreach($response as $r){
			$myHC = 'sudo echo "'.$r->end.'" > /dev/ttyUSB0';
			shell_exec('sudo echo "'.$myHC.'" >> '.$sceneFolderPath.'/end.sh');
		}
		shell_exec('(crontab -l ; echo "'.$schedule->cronjobEnd.' '.$sceneFolderPath.'/end.sh'.'") | crontab -');
	}
}
