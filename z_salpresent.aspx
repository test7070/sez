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
			
			var t_acomp = '';
            aPop = new Array(['txtNoa', 'lblNoa', 'sssall', 'noa,namea', 'txtNoa,txtNamea,txtBdate', 'sssall_b.aspx']);

            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gt('acomp', '', 0, 0, 0, "");
                
                $('#q_report').click(function(e) {
					now_report=$('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report;
					if(now_report=='z_salpresent3'){
						$('#reportnote').text('※此報表為提供勞工局檢查正常出勤報表，非公司內部出勤正常報表。');
						$('#reportnote').show();
					}else{
						$('#reportnote').hide();
					}
				});
            });
            
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_salpresent',
                    options : [{/*[1,2]*/
                        type : '1',
                        name : 'date'
                    }, {/*[3]*/
                        type : '5',
                        name : 'xperson',
                        value : (('').concat(new Array("本國", "日薪", "外勞"))).split(',')
                    }, {/*[4,5]*/
                        type : '2',
                        name : 'sssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sssall_b.aspx'
                    },{/*[6,7]*/
                        type : '2',
                        name : 'partno',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    },{/*[8]*/
                    	type : '0',
                    	name : 'r_len',
                    	value : r_len
                    },{/*[9,10]*/
                        type : '1',
                        name : 'xmon'
                    },{/*[11]*/
                        type : '5',
                        name : 'xorder',
                        value : ('sssno@員工編號,partno@部門-員工,datea@日期').split(',')
                    },{/*[12]*/
                    	type : '0',
                    	name : 'r_proj',
                    	value : q_getPara('sys.project').toUpperCase()
                    }, {/*[13]*/
						type : '5',
						name : 'xacomp',
						value : t_acomp.split(',')
					}]
                });
                
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtDate1').mask(r_picd);
                $('#txtDate1').datepicker();
                $('#txtDate2').mask(r_picd);
                $('#txtDate2').datepicker();
                
                $('#txtXmon1').mask(r_picm);
                $('#txtXmon2').mask(r_picm);
                $('#txtXmon1').val(q_date().substr(0,r_lenm));
                $('#txtXmon2').val(q_date().substr(0,r_lenm));
                
                var tmp = document.getElementById("btnWebPrint");
				var tmpbtn = document.createElement("input");
				tmpbtn.id="btnWebPrint2"
				tmpbtn.type="button"
				tmpbtn.value="雲端列印"
				tmpbtn.style.cssText = "font-size:medium;color: #0000FF;";
				tmp.parentNode.insertBefore(tmpbtn, tmp);
				$('#btnWebPrint').hide();
				
				$('#btnWebPrint2').click(function() {
					if(q_getPara('sys.project').toUpperCase()=='DC' && r_userno=='020129'){//先判斷是否要列印
						if (confirm('是否要列印?'))
							$('#btnWebPrint').click();
					}else{
						$('#btnWebPrint').click();
					}
				});

                $('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));


                if (q_getPara('sys.project').toUpperCase()=='DC' && ((r_rank < 7 && r_userno != '020125' && r_userno != '020113' && r_userno!='040136'))) {
                    $('#txtSssno1a').val(r_userno).attr('disabled', 'disabled');
                    $('#txtSssno2a').val(r_userno).attr('disabled', 'disabled');
                    $('#txtSssno1b').val(r_name);
                    $('#txtSssno2b').val(r_name);
                    $('#btnSssno1').data('events')['click'][0].handler = function() {};
                    $('#btnSssno2').data('events')['click'][0].handler = function() {};
                    var delete_report = 999;
                    for (var i = 0; i < $('#q_report').data().info.reportData.length; i++) {
                        if ($('#q_report').data().info.reportData[i].report == 'z_salpresent2')
                            delete_report = i;
                    }
                    if ($('#q_report div div').text().indexOf('出缺勤明細表') > -1)
                        $('#q_report div div').eq(delete_report).hide();
                }

            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
            	switch (t_name) {
                    case 'acomp':
                        t_acomp = ' @全部';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_acomp += (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_gf('', 'z_salpresent');
                        break;
				}
            }
		</script>
	</head>

	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="reportnote" style="color: red;display: none;width: 1000px;"> </div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

