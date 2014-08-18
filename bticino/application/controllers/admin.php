<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Admin extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            $rol = $this->session->userdata('rol');
            if(!isset($is_logged_in) || $is_logged_in != true){
		header('Location: '.base_url('index.php/session/access'));
            }       
            if($rol != 3){
                $this->session->set_flashdata('message_type', 'warning');
                $this->session->set_flashdata('message_message', 'No tiene los permisos necesarios para acceder a esta sección');
		header('Location: '.base_url('index.php/session/message'));
            }       
        }
	public function users(){
		$this->load->model('user_model');
		$data['users'] = $this->user_model->getAll();
		
		$this->general->head();
		$this->load->view('admin/users', $data);
		$this->load->view('common/tail');
	}
	public function addUser(){
		$rol = $this->input->post('rol');
		$name = $this->input->post('name');
		$last_name = $this->input->post('last_name');
		$username = $this->input->post('username');
		$password = md5($this->input->post('password'));
		$email = $this->input->post('email');
		
		$this->load->model('user_model');
		$this->user_model->insert($rol, $name, $last_name, $username, $password, $email);
		redirect(base_url('index.php/admin/users'), 'refresh');
	}
	public function updateUser(){
		$id = $this->input->post('id');
		$rol = $this->input->post('rol');
		$name = $this->input->post('name');
		$last_name = $this->input->post('last_name');
		$username = $this->input->post('username');
		$password = md5($this->input->post('password'));
		$email = $this->input->post('email');
		
		$this->load->model('user_model');
		$this->user_model->update($id, $rol, $name, $last_name, $username, $password, $email);
		redirect(base_url('index.php/admin/users'), 'refresh');
	}
	public function removeUser(){
		$id = $this->input->post('id');
		
		$this->load->model('user_model');
		$this->user_model->remove($id);
	}
	public function user_add(){
		$this->load->model('rol_model');
		$data['rols'] = $this->rol_model->getAll();
		
		$this->general->head();
		$this->load->view('admin/user_add', $data);
		$this->load->view('common/tail');
	}
	public function user_edit($id){
		$this->load->model('user_model');
		$data['user'] = $this->user_model->getById($id)[0];
		$this->load->model('rol_model');
		$data['rols'] = $this->rol_model->getAll();
		
		$this->general->head();
		$this->load->view('admin/user_add', $data);
		$this->load->view('common/tail');
	}
}
