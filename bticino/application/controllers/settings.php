<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Settings extends CI_Controller {
        public function __construct(){
            parent::__construct();
            $is_logged_in = $this->session->userdata('logged_in');
            if(!isset($is_logged_in) || $is_logged_in != true){
		header('Location: '.base_url('index.php/session/access'));
            }       
        }
	public function hour(){
		$this->general->head();
		$this->load->view('basic_setup');
		$this->load->view('common/tail');
	}
	public function network(){
		$this->general->head();
		$this->load->view('network_settings');
		$this->load->view('common/tail');
	}
    public function setTimeZone(){
    	$zone = $this->input->post('zone');
        shell_exec("sudo cp /usr/share/zoneinfo/".$zone." /etc/localtime");
    }
    public function setNetworkOptions(){
    	$ip = $this->input->post('ip');
    	$mask = $this->input->post('mask');
    	$gateway = $this->input->post('gateway');
	    $myFile = "/etc/network/interfaces";
		$fh = fopen($myFile, 'w') or die("can't open file");
		$stringData = "auto lo\niface lo inet loopback\n\nauto eth0\n";
		fwrite($fh, $stringData);
		$stringData = " iface eth0 inet static\n";
		fwrite($fh, $stringData);
		$stringData = " address ".$ip."\n";
		fwrite($fh, $stringData);
		$stringData = " gateway ".$gateway."\n";
		fwrite($fh, $stringData);
		$stringData = " netmask ".$mask."\n";
		fwrite($fh, $stringData);
		$stringData = " network 192.168.0.0\n";
		fwrite($fh, $stringData);
		$stringData = " broadcast 192.168.0.255\n";
		fwrite($fh, $stringData);
		$stringData = "\nallow-hotplug wlan0\niface wlan0 inet manual\nwpa-roam /etc/wpa_supplicant/wpa_supplicant.conf\niface default inet dhcp\n";
		fwrite($fh, $stringData);
		fclose($fh);
		shell_exec("sudo /etc/init.d/networking restart");
    }
}
