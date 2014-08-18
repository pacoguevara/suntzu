<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Welcome extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            if(!isset($is_logged_in) || $is_logged_in != true){
		header('Location: '.base_url('index.php/session/access'));
            }       
        }
	public function index(){
		$this->general->head();
		$this->load->view('welcome');
		$this->load->view('common/tail');
	}
	public function home(){
		$this->general->head();
		$this->load->view('home');
		$this->load->view('common/tail');
	}
	public function test(){
		$this->general->head();
		$this->load->view('test');
		$this->load->view('common/tail');
	}
}
