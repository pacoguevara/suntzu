<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Commands extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            if(!isset($is_logged_in) || $is_logged_in != true){
		header('Location: '.base_url('index.php/session/access'));
            }       
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
		shell_exec('echo "*#13**66*0##" > /dev/ttyUSB0');
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
	public function executeGottenCommand($command){
		$this->general->generic($command);
	}
	public function executeGottenCommandPost(){
		$command = $this->input->post('command');
		$this->general->generic($command);
	}
}
