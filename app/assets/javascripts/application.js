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
//= require dataTables/jquery.dataTables
//= require jquery.validate.min
//= require additional-methods.min
//= require jquery.tooltipster.min

function store_prev_exceptions(){
	var pathname = window.location.pathname;
	if(pathname.indexOf("/edit") > -1) {
		sessionStorage.setItem("exception_ary", null);
		sessionStorage.setItem("answer_ary", null);
		sessionStorage.setItem("amount_ary",null);
		sessionStorage.setItem("ext_answer_ary",null);
		sessionStorage.setItem("ext_impact",null);
		var exception_ary = [];
		var amount_ary = [];
		var answer_ary= [];
		var ext_answer_ary= [];
		var ext_impact= [];
		$('[id*=_exception]').each(function(){
			exception_ary.push($(this).val());
		})
		$('.ary_answer').each(function(){
			answer_ary.push($(this).val());
		})
		$('[id*=_amount]').each(function(){
			amount_ary.push($(this).val());
		})
		$('[id*=_ext_answer]').each(function(){
			ext_answer_ary.push($(this).val());
		})
		$('[id*=_impact]').each(function(){
			ext_impact.push($(this).val());
		})
		sessionStorage.setItem("exception_ary", exception_ary);
		sessionStorage.setItem("answer_ary", answer_ary);
		sessionStorage.setItem("amount_ary",amount_ary);
		sessionStorage.setItem("ext_answer_ary",ext_answer_ary);
		sessionStorage.setItem("ext_impact",ext_impact);
	}
}

function store_exceptions(){
	var exception_ary = [];
	var answer_ary =[];
	var question_exc_ary=[];
	var amount_ary = [];
	var ext_answer_ary= [];
	var ext_impact= [];
	var question_amount_ary=[]
	$('[id*=_exception]').each(function(){
		exception_ary.push($(this).val());
	})
	$('.ary_answer').each(function(){
		answer_ary.push($(this).val());
	})
	$(".exc_question").each(function(){
		question_exc_ary.push($(this).val());
	})
	$('[id*=_ext_question]').each(function(){
		question_amount_ary.push($(this).val());
	})
	$('[id*=_amount]').each(function(){
		amount_ary.push($(this).val());
	})
	$('[id*=_ext_answer]').each(function(){
		ext_answer_ary.push($(this).val());
	})
	$('[id*=_impact]').each(function(){
		ext_impact.push($(this).val());
	})
	sessionStorage.setItem("exception_ary_final", exception_ary);
	sessionStorage.setItem("question_exc_ary_final", question_exc_ary);
	sessionStorage.setItem("answer_ary_final", answer_ary);

	sessionStorage.setItem("amount_ary_final",amount_ary);
	sessionStorage.setItem("question_amount_ary_final",question_amount_ary);
	sessionStorage.setItem("ext_answer_ary_final",ext_answer_ary);
	sessionStorage.setItem("ext_impact_final",ext_impact);
} 
function form_validate(){
	$("#in_fo").attr("novalidate","novalidate");
	var response=true;
	var sel_exc=false
	var impact=false
	var amount=false;
	$( ".sel_est" ).each(function() {
		if ($(this).val()=='' || $(this).val()==null)
		{
			response=false
			$(this).focus();
			$(this).tooltipster({timer:2000,trigger: 'disbaled',theme:'my-custom-theme'});
			$(this).tooltipster('show')
			sel_exc=true;
			return false;

		}
	});
	$( "[id*=_impact]" ).each(function() {
		if($(this).attr("required")=="required"){
			if (($(this).val()==''  && sel_exc ==false) || $(this).val()==null)
			{

				response=false
				$(this).focus();
				$(this).tooltipster({timer:2000,trigger: 'disbaled',theme:'my-custom-theme'});
				$(this).tooltipster('show');
				impact=true;
				return false;

			}
		}
	});
	$( "[id*=_amount]" ).each(function() {
		if($(this).attr("required")=="required"){
			if (($(this).val()==''  && sel_exc==false  && impact ==false) || $(this).val()==null)
			{

				response=false
				$(this).focus();
				$(this).tooltipster({timer:2000,trigger: 'disbaled',theme:'my-custom-theme'});
				$(this).tooltipster('show');
				amount=true;
				return false;

			}
		}
	});
	$( "[id*=_ext_notes]" ).each(function() {
		if($(this).attr("required")=="required"){
			if ($(this).val()==''  && sel_exc==false  && impact ==false && amount ==false)
			{

				response=false
				$(this).focus();
				$(this).tooltipster({timer:2000,trigger: 'disbaled',theme:'my-custom-theme'});
				$(this).tooltipster('show');
				return false;

			}
		}
	});
		store_exceptions();
		return response;
  
}

$(document).on('click', '#sum_sh_for_edit', function(e){
	e.preventDefault();
	$("#comment_added").text("");
	$('.est_dec').hide();
	$('.adm_com').hide();
	$('.sh_sum').show();
	$('#sh_btn').css('display', 'block');
	$('#comment_btn').css('display', 'block');

	var exception_ary=sessionStorage.getItem("exception_ary").split(",")
	var exception_ary_final=sessionStorage.getItem("exception_ary_final").split(",")
	var question_exc_ary=sessionStorage.getItem("question_exc_ary_final").split(",")

	$.each(exception_ary, function(index, item) {
		if(item!=exception_ary_final[index])
		{
			if(item=="")
			{
				var item1="nil";
			}
			else
			{
				var item1=item	
			}
			if(exception_ary_final[index]=="")
			{
				var item2="nil"
			}
			else
			{
				var item2=exception_ary_final[index]
			}
			$("#comment_added").append("the exception got changed from "+item1+" to "+item2+" for "+question_exc_ary[index]+".\n") }
		});
	var answer_ary=sessionStorage.getItem("answer_ary").split(",")
	var answer_ary_final=sessionStorage.getItem("answer_ary_final").split(",")
	$.each(answer_ary, function(index, item) {
		if(item!=answer_ary_final[index])
		{
			if(item=="")
			{
				var item1="nil";
			}
			else
			{
				var item1=item	
			}
			if(answer_ary_final[index]=="")
			{
				var item2="nil"
			}
			else
			{
				var item2=answer_ary_final[index]
			}
			$("#comment_added").append("the answer got changed from "+item1+" to "+item2+" for "+question_exc_ary[index]+".\n") }
		});

	var amount_ary=sessionStorage.getItem("amount_ary").split(",")
	var amount_ary_final=sessionStorage.getItem("amount_ary_final").split(",")
	var question_amount_ary_final=sessionStorage.getItem("question_amount_ary_final").split(",")

	$.each(amount_ary, function(index, item) {
		if(item!=amount_ary_final[index])
		{
			if(item=="")
			{
				var item1="nil";
			}
			else
			{
				var item1=item	
			}
			if(amount_ary_final[index]=="")
			{
				var item2="nil"
			}
			else
			{
				var item2=amount_ary_final[index]
			}
			$("#comment_added").append("the amount got changed from "+item1+" to "+item2+" for "+question_amount_ary_final[index]+".\n") }
		});
	var ext_answer_ary=sessionStorage.getItem("ext_answer_ary").split(",")
	var ext_answer_ary_final=sessionStorage.getItem("ext_answer_ary_final").split(",")
	
	$.each(ext_answer_ary, function(index, item) {
		if(item!=ext_answer_ary_final[index])
		{
			if(item=="")
			{
				var item1="nil";
			}
			else
			{
				var item1=item	
			}
			if(ext_answer_ary_final[index]=="")
			{
				var item2="nil"
			}
			else
			{
				var item2=ext_answer_ary_final[index]
			}
			$("#comment_added").append("the answer got changed from "+item1+" to "+item2+" for "+question_amount_ary_final[index]+".\n") }
		});
	var ext_impact=sessionStorage.getItem("ext_impact").split(",")
	var ext_impact_final=sessionStorage.getItem("ext_impact_final").split(",")
	
	$.each(ext_impact, function(index, item) {
		if(item!=ext_impact_final[index])
		{
			if(item=="")
			{
				var item1="nil";
			}
			else
			{
				var item1=item	
			}
			if(ext_impact_final[index]=="")
			{
				var item2="nil"
			}
			else
			{
				var item2=ext_impact_final[index]
			}
			$("#comment_added").append("the impact got changed from "+item1+" to "+item2+" for "+question_amount_ary_final[index]+".\n") }
		});
})

$(document).on('ready page:load', function () {
	store_prev_exceptions();
	$('#claim_audit_entry_review').datepicker({ dateFormat: 'mm/dd/yy' });
	$( "#fromdate_estimator" ).datepicker({ dateFormat: 'mm/dd/yy' ,
		onSelect: function(dateText, inst){
			$("#todate_estimator").datepicker("option","minDate",
			$("#fromdate_estimator").datepicker("getDate"));
		}
	});
	$( "#todate_estimator" ).datepicker({ dateFormat: 'mm/dd/yy',
		onSelect: function(dateText, inst){
			$("#fromdate_estimator").datepicker("option","maxDate",
			$("#todate_estimator").datepicker("getDate"));
		}
	});
	$('.aut_sz').autosize();
	$('#sort_cols').dataTable();
	$("#new_claim_awaiting_audit").validate({
		rules: { file_csv: { required: true, accept: "csv" }},
		messages: {
            file_csv: {accept: 'Please upload a csv file!'}
        }
	});
});


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
	var response=false;
	var sel=false
	var exc=false
	$( ".sel_ans" ).each(function() {
		if ($(this).val()=='' || $(this).val()==null)
		{
			response=true
			$(this).focus();
			$(this).tooltipster({timer:2000,trigger: 'disbaled',theme:'my-custom-theme'});
			$(this).tooltipster('show')
			sel=true;
			return false;

		}
	});
	$( "[id*=_exception]" ).each(function() {
		if($(this).attr("required")=="required"){
			if (($(this).val()==''  && sel ==false) || $(this).val()==null)
			{

				response=true
				$(this).focus();
				$(this).tooltipster({timer:2000,trigger: 'disbaled',theme:'my-custom-theme'});
				$(this).tooltipster('show');
				exc=true;
				return false;

			}
		}
	});
	$(".note_text_first").each(function(){
		if($(this).attr("required")=="required")
		{
			if ($(this).val()=='' && exc==false  && sel ==false)
			{
				response=true
				$(this).focus();
				$(this).tooltipster({timer:2000,trigger: 'disbaled',theme:'my-custom-theme'});
				$(this).tooltipster('show');
				return false;
	
			}
		}
	})
	
	if(response==false)
	{
		$('.adm_com').hide();
		$('.est_dec').show();
		$('.sel_est').attr('required', true);
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
	else if($(this).val()== "Yes" || $(this).val() == "n/a"){
		$(this).parent().next().next().children('textarea').removeAttr('required');
		$(this).parent().parent().find('select:last').attr('disabled', true);
		$(this).parent().parent().find('select:last').val('0');
		// $(this).parent().parent().find('select:last').attr('option',"select");
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
		$(this).parent().parent().find('input,select').focus();
	}
	else if($(this).val()== "Yes" || $(this).val() == "n/a"){
		$(this).parent().next().next().next().children('textarea').removeAttr('required');
		$(this).parent().parent().find('input:visible, select:last').attr('disabled', true);
		$(this).parent().parent().find('input,select').removeAttr('required');
	}
})


$(document).on('click', '#go_back_to_edit', function(e){
	history.go(-1);
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

$(document).on('blur', '[id*=_amount]', function(e){
	min_amt = $(this).parent().find('input:hidden').val();
	if(parseInt($(this).val()) <= parseInt(min_amt)){
		alert("Your value must be greater than "+min_amt +" ");
		$(this).focus();
		$(this).val('');
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

$(document).on('focus', '.req_fd', function(e){
	$(this).attr('required', true);
	$('.cla_only').attr('required', false);
})

$(document).on('focus', '.cla_only', function(e){
	$(this).attr('required', true);
	$('.req_fd').attr('required', false);
})
