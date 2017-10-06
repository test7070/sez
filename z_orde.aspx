<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
            var acompItem = '';
            var t_first=true;
            $(document).ready(function() {
                q_getId();
                q_gt('acomp', '', 0, 0, 0, "");
                
                $('#qReport').click(function(e) {
					if(window.parent.q_name=="orde" && q_getPara('sys.project').toUpperCase()=='XY' ){
						var delete_report=999;
						for(var i=0;i<$('#qReport').data().info.reportData.length;i++){
							if($('#qReport').data().info.reportData[i].report!='z_orde5_xy')
								$('#qReport div div').eq(i).hide();
						}
												
						$('#qReport div div .radio').parent().each(function(index) {
							if(!$(this).is(':hidden') && t_first){
								$(this).children().removeClass('nonselect').addClass('select');
								t_first=false;
							}
							if($(this).is(':hidden') && t_first){
								$(this).children().removeClass('select').addClass('nonselect');
							}
						});
					}
				});
                
            });
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        acompItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            acompItem = acompItem + (acompItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_gf('', 'z_orde');
                        break;
                }
            }

            function q_gfPost() {
                $('#qReport').q_report({
                    fileName : 'z_orde',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '1', //[2][3]
                        name : 'xdate'
                    }, {
                        type : '1', //[4][5]
                        name : 'xodate'
                    }, {
                        type : '2', //[6][7]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2', //[8][9]
                        name : 'xsales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2', //[10][11]
                        name : 'xproduct',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {
                        type : '5', //[12]
                        name : 'xstype',
                        value : [q_getPara('report.all')].concat(q_getPara('orde.stype').split(','))
                    }, {
                        type : '5', //[13]
                        name : 'xtran',
                        value : [q_getPara('report.all')].concat(q_getPara('sys.tran').split(','))
                    }, {
                        type : '5', //[14]
                        name : 'xcancel',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    }, {
                        type : '5', //[15]
                        name : 'xend',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    }, {
                        type : '0', //[16] //判斷是否顯示規格
                        name : 'isspec',
                        value : q_getPara('sys.isspec')
                    },{
                        type : '5', //[17]
                        name : 'xcno',
                        value : acompItem.split(',')
                    },{
						type : '0',//[18]
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					},{
                        type : '5', //[19]
                        name : 'xorder',
                        value : ('odate@訂單日,cust@客戶,orde@訂單,datea@預交日').split(',')
                    },{
                    	type : '8',//[20]
						name : 'xshowenda',
						//value : "1@依單據排序,2@依訂單日期排序,3@依預交日期排序".split(',')
						value : "1@".split(',')
					},{
                        type : '8',//[21]
                        name : 'xshowenda1',
                        value : "2@".split(',')
                    },{
                        type : '8',//[22]
                        name : 'xshowenda2',
                        value : "3@".split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#Xshowenda').css('width', '300px').css('height', '30px');
                $('#Xshowenda .label').css('width','90px');
                $('#chkXshowenda').css('width', '0px').css('margin-top', '5px');
                $('#chkXshowenda span').css('width','0px');
                
                $('#Xshowenda1').css('width', '300px').css('height', '30px');
                $('#Xshowenda1 .label').css('width','120px');
                $('#chkXshowenda1').css('width', '0px').css('margin-top', '5px');
                $('#chkXshowenda1 span').css('width','0px');
                
                $('#Xshowenda2').css('width', '300px').css('height', '30px');
                $('#Xshowenda2 .label').css('width','120px');
                $('#chkXshowenda2').css('width', '0px').css('margin-top', '5px');
                $('#chkXshowenda2 span').css('width','0px');

                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                              
                /*$('#chkXshowenda input').click(function(){ 
						var tcheck=$(this).val(); 
						$('#chkXshowenda input').each(function() {
							if(tcheck!=$(this).val()){ 
								$(this).prop('checked',false);
							}
						});  
				});*/
				$('#chkXshowenda input').click(function(){ 
				    $('#chkXshowenda1 input').prop('checked',false);
				    $('#chkXshowenda2 input').prop('checked',false);
				});
				
				$('#chkXshowenda1 input').click(function(){ 
                    $('#chkXshowenda input').prop('checked',false);
                    $('#chkXshowenda2 input').prop('checked',false);
                });
				
				$('#chkXshowenda2 input').click(function(){ 
                    $('#chkXshowenda input').prop('checked',false);
                    $('#chkXshowenda1 input').prop('checked',false);
                });
				
				$('#Xend select').val('0')			
                
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').datepicker();
                $('#txtXodate1').mask(r_picd);
                $('#txtXodate1').datepicker();
                $('#txtXodate2').mask(r_picd);
                $('#txtXodate2').datepicker();
                
                $('#txtXodate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXodate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                
                $('#qReport div div .radio.select').click();
                
                
                if(q_getPara('sys.project').toUpperCase()=='XY' ){
                	$('#Xorder select').append($('<option>', {
					    value: 'percent',
					    text: '比例'
					}));
                }
                
                if(window.parent.q_name=="orde" && q_getPara('sys.project').toUpperCase()=='XY' ){
                	$('#txtXodate1').val('');
                	$('#txtXodate2').val('');
                	$('#txtXcust1a').val(window.parent.$('#txtCustno').val());
                	$('#txtXcust1b').val(window.parent.$('#txtComp').val());
                	$('#txtXcust2a').val(window.parent.$('#txtCustno').val());
                	$('#txtXcust2b').val(window.parent.$('#txtComp').val());
                	$('#btnOk').click();
                }
            }

            function q_boxClose(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>