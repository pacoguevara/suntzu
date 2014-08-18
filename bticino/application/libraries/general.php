<?php defined('BASEPATH') OR exit('No direct script access allowed');

class General{
    public function head(){
    	$ci =& get_instance();
    	
	    $ci->load->model('floor_model');
		$data['floors'] = $ci->floor_model->getAll();
		$ci->load->view('common/head', $data);
    }
    public function create_net(){
		shell_exec('echo "*13*30*##" > /dev/ttyUSB0');
	}
	public function join_net(){
		shell_exec('echo "*13*33*##" > /dev/ttyUSB0');
	}
	public function open_net(){
		shell_exec('echo "*13*32*##" > /dev/ttyUSB0');
	}
	public function close_net(){
		shell_exec('echo "*13*31*##" > /dev/ttyUSB0');
	}
	public function leave_net(){
		shell_exec('echo "*13*34*##" > /dev/ttyUSB0');
	}
	public function scan_net(){
		shell_exec('echo "*13*65*##" > /dev/ttyUSB0');
	}
	public function on(){
		shell_exec('echo "*1*1*702442500#9##" > /dev/ttyUSB0');
	}
	public function off(){
		shell_exec('echo "*1*0*702442500#9##" > /dev/ttyUSB0');
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
	public function generic($command){
		shell_exec('echo "'.$command.'" > /dev/ttyUSB0');
	}
}