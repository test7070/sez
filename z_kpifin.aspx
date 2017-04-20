<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var isFirst = true;
            var t_year = '';

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gt('tables', "where=^^ TABLE_NAME like 'accc[0-9][0-9][0-9]_[0-9]' ^^", 0, 0, 0, "init1");

            });
            function q_gtPost(t_name) {
                switch (t_name) {
                case 'init1':
                    var as = _q_appendData("INFORMATION_SCHEMA.TABLES", "", true);
                    tmp = new Array();
                    if (as[0] != undefined) {
                        for ( i = 0; i < as.length; i++) {
                            tmp.push(as[i].TABLE_NAME.replace(/accc([0-9][0-9][0-9])\_[0-9]/g, '$1'));
                        }
                    }
                    tmp.sort(sortNumber);
                    t_year = '';
                    if (r_picm.length == 6) {
                        for (var i in tmp) {
                            t_year += (t_year.length > 0 ? ',' : '') + tmp[i];
                        }
                    } else {
                        for (var i in tmp) {
                            t_year += (t_year.length > 0 ? ',' : '') + (parseInt(tmp[i]) + 1911);
                        }
                    }
                    q_gf('', 'z_kpifin');
                    break;
                }
            }

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_kpifin',
                    options : [{
                        type : '0', //[1]
                        name : 'path',
                        value : location.protocol + '//' + location.hostname + location.pathname.toLowerCase().replace('z_kpifin.aspx', '')
                    }, {
                        type : '0', //[2]
                        name : 'db',
                        value : q_db
                    }, {
                        type : '0', //[3]
                        name : 'project',
                        value : q_getPara('sys.project').toUpperCase()
                    }, {
                        type : '0', //[4]
                        name : 'data1',
                        value : ''
                    }, {
                        type : '0', //[5]
                        name : 'data2',
                        value : ''
                    }, {
                        type : '0', //[6]
                        name : 'data3',
                        value : ''
                    }, {
                        type : '0', //[7]
                        name : 'data4',
                        value : ''
                    }, {
                        type : '5', //[8]
                        name : 'xyear',
                        value : t_year.split(',')
                    }]
                });
                q_popAssign();
                q_langShow();
                
                $('#btnOk').before($('#btnOk').clone().attr('id', 'btnOk2').show()).hide();
                $('#btnOk2').click(function(e){
            		switch($('#q_report').data('info').radioIndex) {
                        case 0:
                        	var t_bdate = $('#Xyear').find('select').val()+'/01/01';
							var t_edate = $('#Xyear').find('select').val()+'/12/31';
							isFirst = true;
							q_func('z_acbe.z_acbe1y', t_bdate + "," + t_edate);
                        default:
                           	$('#btnOk').click();
                            break;
                    }
            	});
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'z_acbe.z_acbe1y':
	                    if (result.substr(0, 5) == '<Data') {/// 如果傳回  table[]
	                        var as = _q_appendData('tmp0', '', true);
	                        console.log(as);
	                        var tmpdata = "";
	                        for(var i=0;i<as.length;i++){
	                        	var acc1 = as[i].acc1.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var acc2 = as[i].acc2.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var money = as[i].money.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	money = money.replace(/\((.*)\)/,'-$1').replace(/,/g,'');
	                        	var total = as[i].total.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	total = total.replace(/\((.*)\)/,'-$1').replace(/,/g,'');
	                        	var type1 = as[i].type1.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	tmpdata += (tmpdata.length>0?'~~':'')+ acc1+"^"+acc2+"^"+money+"^"+total+"^"+type1;
	                        }
	                        if(isFirst){
	                        	$('#q_report').data('info').options[3].value=tmpdata;
	                        	var t_date = $('#Xyear').find('select').val()+'/12/31';
	                        	q_func( 'z_acset.z_acset1y',   t_date  );
	                        }else{
	                        	$('#q_report').data('info').options[5].value=tmpdata;
	                        	var t_date = $('#Xyear').find('select').val()+'/12/31';
	                        	q_func( 'z_acset.z_acset1y',   t_date  );
	                        }
	                    } 
	                    break;
                    case 'z_acset.z_acset1y':
                    	if (result.substr(0, 5) == '<Data') {/// 如果傳回  table[]
	                        var as = _q_appendData('tmp0', '', true);
	                        console.log(as);
	                        var tmpdata = "";
	                        for(var i=0;i<as.length;i++){
	                        	var dacc1 = as[i].dacc1.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var dname = as[i].dname.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var dno = as[i].dno.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var dmoney = as[i].dmoney.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	dmoney = dmoney.replace(/\((.*)\)/,'-$1').replace(/,/g,'');
	                        	
	                        	var cacc1 = as[i].cacc1.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var cname = as[i].cname.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var cno = as[i].cno.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	var cmoney = as[i].cmoney.replace(/<.*>(.*)<\/.*>/,'$1').replace(/[ ]+/g,'').replace(/[　]+/g,'');
	                        	cmoney = cmoney.replace(/\((.*)\)/,'-$1').replace(/,/g,'');
	                        	
	                        	tmpdata += (tmpdata.length>0?'~~':'')+ dacc1+"^"+dname+"^"+dno+"^"+dmoney+"^"+ cacc1+"^"+cname+"^"+cno+"^"+cmoney;
	                        }
	                       
	                        if(isFirst){
	                        	 $('#q_report').data('info').options[4].value=tmpdata;
		                        //去年的資料
		                        var t_bdate = $('#Xyear').find('select').val()+'/01/01';
								var t_edate = $('#Xyear').find('select').val()+'/12/31';
								isFirst = false;
								q_func('z_acbe.z_acbe1y', t_bdate + "," + t_edate);
	                        }else{
	                        	 $('#q_report').data('info').options[6].value=tmpdata;
	                        	 $('#btnOk').click();
	                        }
	                    }
                    	break;
                    default:
                    	break;
                }
            }

            function q_boxClose(t_name) {
            }
            function sortNumber(a, b) {
                var n = parseInt(a.substring(0, 3));
                var m = parseInt(b.substring(0, 3));
                return m - n;
            }
            function getYear(value){
            	var r = "";
            	try{
            		switch(value.length){
	            		case 10: //2017/04/18
	            			r = (parseInt(value.substring(0,4))-1911)+"";
	            			break;
	        			case 9: //106/04/18
	            			r = value.substring(0,3);
	            			break;
            			case 7: //2017/04
	            			r = (parseInt(value.substring(0,4))-1911)+"";
	            			break;
	        			case 6: //106/04
	            			r = value.substring(0,3);
	            			break;
            			case 4: //2017
	            			r = (parseInt(value.substring(0,4))-1911)+"";
	            			break;
	        			case 3: //106
	            			r = value.substring(0,3);
	            			break;
	            		default:
	            			return "";
	            			break;	
	            	}
            	}catch(e){}
            	return r;
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">

		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>

	</body>
</html>