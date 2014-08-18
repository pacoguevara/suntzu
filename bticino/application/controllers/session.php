<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Session extends CI_Controller {
	public function access(){
		$this->load->view('login');
	}
	public function login(){
		$username = $this->input->post('username');
		$password = $this->input->post('password');
		
		$this->load->model('user_model');
		$user = $this->user_model->check($username, md5($password));
		
		if($user){
                    $newdata = array(
                       'id'  => $user[0]->id,
                       'name'  => $user[0]->name,
                       'last_name'  => $user[0]->last_name,
                       'email'     => $user[0]->email,
                       'username'     => $user[0]->username,
                       'rol'     => $user[0]->rol,
                       'logged_in' => true
                    );
	
                    $this->session->set_userdata($newdata);
                    header('Location: '.base_url('index.php/welcome/'));
		}else{
		    header('Location: '.base_url('index.php/session/access'));
		}
	}
	public function logout(){
		$this->session->sess_destroy();
                header('Location: '.base_url('index.php/session/access'));
	}
        public function message(){
            $this->general->head();
            $this->load->view('message');
            $this->load->view('common/tail');
        }
}
