// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery.autosize.min
//= require jquery-ui


$(document).ready(function(){
	$('#claim_audit_entry_review').datepicker({ dateFormat: 'dd-mm-yy' });
	$( "#fromdate_estimator" ).datepicker({ dateFormat: 'dd-mm-yy' });
	$( "#todate_estimator" ).datepicker({ dateFormat: 'dd-mm-yy' });
	$('.aut_sz').autosize();
})

$(document).on('click', '#Main_claim_audit_list', function(e){
	window.location="/estimator_claim_audit_list/index"
})

$(document).on('click', '#submit_to_filter_audit', function(e){
	var from_date=$("#fromdate_estimator").val();
	var to_date=$("#todate_estimator").val();
	var estimator_id=$("#estimator").val();
	var carrier_id=$("#carrier").val();
	if(from_date=="" || to_date=="" || estimator_id=="") {
		alert("Please fill up the dates and select estimator!")
	}
	else
	{
		$.ajax({url:"/estimator_claim_audit_list/filtered_list?from_date="+from_date+"&to_date="+to_date+"&estimator="+estimator_id+"&carrier="+carrier_id})
	}

});
$(document).on('click', '#hd_ad', function(e){
	e.preventDefault();
	response=false;
	$( ".sel_ans" ).each(function() {
		if ($(this).val()=='')
		{
			response=true
		}
		else
		{
			response=false
		}
	});
	$(".note_text_first").each(function(){
		if($(this).attr("required")=="required")
		{
			if ($(this).val()=='')
			{
				response=true
			}
			else
			{
				response=false
			}
		}
	})
	
	if(response==false){
		$('.adm_com').hide();
		$('.est_dec').show();
		$('.sel_est').attr('required', true);
	}
	else{
		alert("Please fill the focused field");
		$('#in_fo').find('input:required, select:required,textarea:required').each(function(){
			if($(this).val()==""){
				$(this).focus();
			}
		});
	}
})

$(document).on('click', '#hd_add', function(e){
	e.preventDefault();
	$('.adm_com').hide();
	$('.est_dec').show();
})
$(document).on('click', '#prev_ll', function(e){
	e.preventDefault();
	$('.adm_com').show();
	$('.est_dec').hide();
})
$(document).on('click', '#prev_from_comment_history', function(e){
	e.preventDefault();
	$('.adm_com').hide();
	$('.est_dec').hide();
	$('.sh_sum').show();
	$('.comment_block').hide();
})
$(document).on('click', '#comment_btn', function(e){
	e.preventDefault();
	$('.adm_com').hide();
	$('.est_dec').hide();
	$('.sh_sum').hide();
	$('.comment_block').show();
})

$(document).on('click', '#sh_ad', function(e){
	$('.est_dec').hide();
	$('.adm_com').show();
	
	
})

$(document).on('change', '.sel_ans', function(){
	if($(this).val() == "No"){
		$(this).parent().parent().find('input:last, select:last').attr('disabled', false);
		$(this).parent().next().next().children('textarea').attr('required', 'required');
		//alert("Please fill the comments in the notes field");
		$(this).parent().parent().find('input').attr('required', 'required');
		$(this).parent().parent().find('select:last').attr('required', 'required');
		$(this).parent().parent().find('select').focus();
	}
	else if($(this).val()== "Yes"){
		$(this).parent().next().next().children('textarea').removeAttr('required');
		$(this).parent().parent().find('select:last').attr('disabled', true);
		$(this).parent().parent().find('input, select').removeAttr('required');
	}
})

$(document).on('change', '.sel_est', function(){
	if($(this).val() == "No"){
		//alert("Please fill the ammount, impact and comments in their respective fields");
		$(this).parent().next().next().next().children('textarea').attr('required', 'required');
		$(this).parent().parent().find('input:visible, select:last').attr('disabled', false);
		$(this).parent().parent().find('input').attr('required', 'required');
		$(this).parent().parent().find('select:last').attr('required', 'required');
		$(this).parent().parent().find('input:select').focus();
	}
	else if($(this).val()== "Yes"){
		$(this).parent().next().next().next().children('textarea').removeAttr('required');
		$(this).parent().parent().find('input:visible, select:last').attr('disabled', true);
		$(this).parent().parent().find('input, select').removeAttr('required');
	}
})

$(document).on('click', 'su_btn', function(e){
	e.preventDefault();
	if($('#in_fo')[0].checkValidity('input:visible')){
		$('#in_fo')[0].submit();
	}
	else{
		alert("please fill in all the fields for the questions where your answer is No");
	}
})
$(document).on('click', '#go_back_to_edit', function(e){
	history.go(-1);
})

$(document).on('click', '#go_back_to_result', function(e){
	var from_date=$("#filter_from_date").val();
	var to_date=$("#filter_to_date").val();
	var estimator_id=$("#filter_estimator_id").val();
	var carrier_id=$("#filter_carrier_id").val();
	$.ajax({url:"/estimator_claim_audit_list/back_filtered_list?from_date="+from_date+"&to_date="+to_date+"&estimator_id="+estimator_id+"&carrier_id="+carrier_id})
	
})

$(document).on('click', '#sum_sh', function(e){
	e.preventDefault();
	$('.est_dec').hide();
	$('.adm_com').hide();
	$('.sh_sum').show();
	$('#sh_btn').css('display', 'block');
	$('#comment_btn').css('display', 'block');
})

$(document).on('click', '#sho_ad', function(e){
	$('.est_dec').hide();
	$('.adm_com').show();
})

$(document).on('change', '#que_sel', function(e){
	if($(this).val() != "Estimation Decisions"){
		$('.sh_exp').show();
		$('.sh_amt').hide();
	}
	else if($(this).val() == "Estimation Decisions"){
		$('.sh_amt').show();
		$('.sh_exp').hide();
	}
})

$(document).on('blur', '.check_min_amt', function(e){
	min_amt = $(this).parent().find('input:hidden').val();
	if($(this).val() <= min_amt){
		alert("Your value must be greater than "+min_amt +" ");
		$(this).focus();
		value = parseInt(min_amt) + 1;
		$(this).val(value);
	}
})

$(document).on('click', '#back_to_result', function(e){
	history.go(-1);
})

$(document).on('click', '#save_comment', function(e){
	e.preventDefault();
    $.ajax({
        url: '/claim_audit_comments/save',
		type: 'post',
        data: $("form#sv_ad_cm").serialize(),
        dataType: "JSON",
		async: false,
		success: function(data){
			if(data == true){
				$('body').find('.alert_html').html('<div class="alert alert-success"><button class="close" data-dismiss="alert" type="button">x</button>Comment Successfully Added</div>');
				$('#div_ref').load(window.location + " #test-div");
				$('.comment_block').show();
			}
		},
		error: function(error){
			alert("Request failed. Sorry, we are analyzing the cause of this problem");
		}
    })
})

$(document).on('click', '#prev_from_summary', function(e){
	e.preventDefault();
	$('.adm_com').hide();
	$('.est_dec').show();
	$('.sh_sum').hide();
	$('.comment_block').hide();
})

$(document).on('click', '#prev_from_summary1', function(e){
	e.preventDefault();
	$('.adm_com').hide();
	$('.est_dec').show();
	$('.sh_sum').hide();
	$('#sh_btn').hide();
})
