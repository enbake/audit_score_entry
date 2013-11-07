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
//= require ace.min
//= require fuelux.wizard
//= require bootstrap
//= require bootstrap-datetimepicker.min
//= require_tree .

$(document).ready(function(){
	$('#datetimepicker2').datetimepicker({
	  language: 'en',
	  pick12HourFormat: true
	});
})

$(document).on('click', '#hd_ad', function(e){
	e.preventDefault();
	if($('#in_fo')[0].checkValidity('input:visible')){
		$('.adm_com').hide();
		$('.est_dec').show();
		$('.sel_est').attr('required', true);
	}
	else{
		//alert("please fill in the corresponding fields for the questions where your answer is No");
		alert("Please fill the focused field");
		$('#in_fo').find('input:required, select:required').each(function(){
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

$(document).on('click', '#sh_ad', function(e){
	e.preventDefault();
	if ($('#in_fo')[0].checkValidity('input:visible')) {
		$('.est_dec').hide();
		$('.adm_com').show();
	}
	else{
		alert("Please fill the focused field");
		$('#in_fo').find('input:required, select:required').each(function(){
			if($(this).val()==""){
				$(this).focus();
			}
		});
	}
})

$(document).on('change', '.sel_ans', function(){
	if($(this).val() == "No"){
		//alert("Please fill the comments in the notes field");
		$(this).parent().parent().find('input').attr('required', true);
		$(this).parent().parent().find('select:last').attr('required', true);
		$(this).parent().parent().find('select').focus();
	}
	else if($(this).val()== "Yes"){
		$(this).parent().parent().find('input, select').attr('required', false);
	}
})

$(document).on('change', '.sel_est', function(){
	if($(this).val() == "No"){
		//alert("Please fill the ammount, impact and comments in their respective fields");
		$(this).parent().parent().find('input').attr('required', true);
		$(this).parent().parent().find('select:last').attr('required', true);
		$(this).parent().parent().find('input:select').focus();
	}
	else if($(this).val()== "Yes"){
		$(this).parent().parent().find('input, select').attr('required', false);
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

$(document).on('click', '#sum_sh', function(e){
	e.preventDefault();
	$('.est_dec').hide();
	$('.adm_com').hide();
	$('.sh_sum').show();
	$('#sh_btn').css('display', 'block');
})
