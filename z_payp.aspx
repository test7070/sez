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
            var gfrun = false;
            var partItem = '';
            $(document).ready(function() {
            	q_getId();
                if (partItem.length == 0) {
                    q_gt('part', '', 0, 0, 0, "");
                }
            });
            function q_gfPost() {
               $('#q_report').q_report({
						fileName : 'z_payp',
						options : [ {
						type : '1',
						name : 'xnoa'
					},{
                    	type : '0',//[3]
                        name : 'xlen',
                        value : r_len
                    },{
						type : '0',
	                    name : 'r_tel',
	                    value : q_getPara('sys.tel')
					},{
	                    type : '0',
	                    name : 'r_addr',
	                    value : q_getPara('sys.addr')
					},{
                        type : '1',
                        name : 'xdate'
                    }, {
                        type : '2',
                        name : 'cno',
                        dbf : 'acomp',
                        index : 'noa,acomp',
                        src : 'acomp_b.aspx'
                    }, {
                        type : '5',
                        name : 'tpart',
                        value : partItem.split(',')
                    }]
				});
                q_popAssign();
                q_getFormat();
                q_langShow();

                 $('#txtXdate1').mask(r_picd);
                 //$('#txtXdate1').datepicker();
                 $('#txtXdate2').mask(r_picd);
                 //$('#txtXdate2').datepicker(); 
                
           		var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            	
	            }else{
	            	$('#txtXnoa1').val(t_para.noa);
                	$('#txtXnoa2').val(t_para.noa);
	            }
	            $('#btnOk').hide();	     
                $('#btnOk2').click(function(e) {
                    /*switch($('#q_report').data('info').radioIndex) {
                        case 0:
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 1:
                            $('#chkLandScape').prop('checked',true);
                            break;
                        default:
                            $('#chkLandScape').prop('checked',false);
                            break;
                    }*/ //橫印關閉
                    $('#btnOk').click();
                });
            }

            function q_boxClose(s2) {
            }
            function q_gtPost(s2) {
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                     case 'part':
                        var as = _q_appendData("part", "", true);
                        partItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            partItem = partItem + (partItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        break;   
                }
                if (partItem.length > 0 && !gfrun) {
                    gfrun = true;
                    q_gf('', 'z_payp');
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
			<div class="prt" style="margin-left: -40px;">
                <input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;" value="查詢"/>
                <!--#include file="../inc/print_ctrl.inc"-->
            </div>
		</div>
	</body>
</html>
           
          