<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911)+"_1";
            }
            function z_accc() {
            }
            z_accc.prototype = {
                data : {
                    part : null
                },
                keyup : null
            };
            t_data = new z_accc();
            
            var ssspart;
            $(document).ready(function() {
                q_getId();
                q_gt('acpart', '', 0, 0, 0, "", r_accy+'_'+r_cno);
                q_gt('ssspart', "where=^^noa='"+r_userno+"'^^", 0, 0, 0, "", r_accy+'_'+r_cno);
            });
             
            function q_gfPost() {
            	init_finish=true;
                $('#q_report').q_report({
                    fileName : 'z_acccp',
                    options : [{/*  [1]*/
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    },{/*  [2]*/
                        type : '0',
                        name : 'xrank',
                        value : r_rank
                    }, {/*1  [3],[4]*/
                        type : '1',
                        name : 'xaccc3'
                    }, {/*4 [5]*/
                        type : '8',
                        name : 'xpart',
                        value : ('zzzzz@無部門,'+t_data.data['part']).split(',')
                    }]
                });
                q_popAssign();
                q_langShow();
                
                if(q_getPara('acc.lockPart')=='1' && r_rank<8){
		        	$("#chkXpart").children('input').attr('Disabled','Disabled');
		        	$('#chkXpart').children('input').prop('checked',false);
		        	for(var i=0;i<$('#chkXpart').children('input').length;i++){
		        		if ($('#chkXpart').children('input')[i].value==r_partno || i==0){
		        			$('#chkXpart').children('input')[i].checked=true;
		        			continue;
		        		}
		        		for(var j=0;j<ssspart.length;j++){
		        			if ($('#chkXpart').children('input')[i].value==ssspart[j].partno){
			        			$('#chkXpart').children('input')[i].checked=true;
			        			break;
			        		}
		        		}
		        	}
		        }
				if(q_getPara('sys.comp').indexOf('旭暉')>=0){
		        	$('#chkXpart').children('input').prop('checked',true)
		        }
                var t_accc3=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
                t_accc3  =  t_accc3.replace('accc3=','');
                $('#txtXaccc31').val(t_accc3);
                $('#txtXaccc32').val(t_accc3);
                
                $('#btnOk').hide();
                $('#btnOk2').click(function(e) {
                    /*switch($('#q_report').data('info').radioIndex) {
                        case 0:
                            $('#cmbPaperSize').val('LETTER');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 1:
                            $('#cmbPaperSize').val('LETTER');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        default:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                    }*/
                    $('#btnOk').click();
                });
                
            }
            
            var init_finish=false,init_acpart=false,init_ssspart=false;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acpart':
                        t_data.data['part'] = '';
                        var as = _q_appendData("acpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['part'] += (t_data.data['part'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        
                        init_acpart=true;
                        break;
					case 'ssspart':
						ssspart = _q_appendData("ssspart", "", true);
						init_ssspart=true;
						break;
                }
                if(init_acpart&&init_ssspart&&!init_finish)
                	q_gf('', 'z_acccp');
            }
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
                <input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;width:50px;height:30px;" value="查詢"/>
                <!--#include file="../inc/print_ctrl.inc"-->
            </div>
		</div>
	</body>
</html>