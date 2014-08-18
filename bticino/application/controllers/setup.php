<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Setup extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            if(!isset($is_logged_in) || $is_logged_in != true){
		header('Location: '.base_url('index.php/session/access'));
            }
            $rol = $this->session->userdata('rol');
            if($rol == 1){
                $this->session->set_flashdata('message_type', 'warning');
                $this->session->set_flashdata('message_message', 'No tiene los permisos necesarios para acceder a esta sección');
		header('Location: '.base_url('index.php/session/message'));
            }      
        }
	public function index()
	{
		$this->general->head();
		$this->load->view('setup_home');
		$this->load->view('common/tail');
	}
	public function network(){
		$this->general->head();
		$this->load->view('setup_network');
		$this->load->view('common/tail');
	}
	public function create(){
		$this->general->create_net();
		$this->general->head();
		$this->load->view('setup_new');
		$this->load->view('common/tail');
	}
	public function join(){
		//Send *13*33*## to the dongle
		$this->general->head();
		$this->load->view('setup_join');
		$this->load->view('common/tail');
	}
	public function scan(){
		$this->general->scan_net();
	}
	public function populate(){
		$this->load->model('device_type_model');
		$data['device_types'] = $this->device_type_model->all();
		$this->general->head();
		$this->load->view('setup_populate', $data);
		$this->load->view('common/tail');
	}
	public function done(){
		$this->load->model('device_model');
		$data['devices'] = $this->device_model->getAll();
		
		$this->general->close_net();
		$this->general->head();
		$this->load->view('setup_done', $data);
		$this->load->view('common/tail');
	}
	public function leave(){
		$this->general->leave_net();
	}
	public function insertDevice(){
		$serial = $this->input->post('serial');
		$name = $this->input->post('name');
		$type = $this->input->post('type');
		
		$this->load->model('device_model');
		$this->device_model->insert($serial, $name, $type);
	}
}
