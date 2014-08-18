<?php
    $this->session->keep_flashdata('message_type');
    $this->session->keep_flashdata('message_message');
?>
<div class="alert alert-<?php echo $this->session->flashdata('message_type');?>" role="alert">
    <?php echo $this->session->flashdata('message_message');?>
</div>
