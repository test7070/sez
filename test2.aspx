<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
		
		<script type="text/javascript">
			
            $(document).ready(function() {
 
            	$('#btnRun').click(function(e){
            		var t_year = parseInt($('#txtYear').val());
	        		var sqlStr="SET QUOTED_IDENTIFIER OFF" + String.fromCharCode(13);
	        		sqlStr+= "declare @cmd nvarchar(max)"+ String.fromCharCode(13);
	        		sqlStr+= vcc(t_year-1);
					sqlStr+= vcc(t_year);
					sqlStr+= vcc(t_year+1);
					sqlStr+= view_vcc(t_year);
            		$('#file').attr('download','addTable.sql');
            		$('#file').attr('href',"data:text/plain;base64," + btoa(sqlStr));
            	});
            });
            
            function vcc(year){
            	return "if not exists(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE UPPER(TABLE_NAME)='VCC"+year+"' )"+ String.fromCharCode(13)
					+"begin"+ String.fromCharCode(13)		
            		+"    CREATE TABLE [dbo].[vcc"+year+"](" + String.fromCharCode(13)
            		+"        [noa] [nvarchar](20) NOT NULL," + String.fromCharCode(13)
					+"        [typea] [nvarchar](10) NULL," + String.fromCharCode(13)
					+"        [custno] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [comp] [nvarchar](40) NULL," + String.fromCharCode(13)
					+"        [nick] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [tel] [nvarchar](90) NULL," + String.fromCharCode(13)
					+"        [addr] [nvarchar](90) NULL," + String.fromCharCode(13)
					+"        [salesno] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [sales] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [datea] [nvarchar](10) NULL," + String.fromCharCode(13)
					+"        [payed] [decimal](12, 2) NULL," + String.fromCharCode(13)
					+"        [unpay] [decimal](12, 2) NULL," + String.fromCharCode(13)
					+"        [unpay2] [decimal](12, 2) NULL," + String.fromCharCode(13)
					+"        [usunpay] [decimal](16, 4) NULL," + String.fromCharCode(13)
					+"        [uspayed] [decimal](16, 4) NULL," + String.fromCharCode(13)
					+"        [ustotal] [decimal](16, 4) NULL," + String.fromCharCode(13)
					+"        [discount] [decimal](9, 0) NULL," + String.fromCharCode(13)
					+"        [money] [decimal](12, 0) NULL," + String.fromCharCode(13)
					+"        [tax] [decimal](9, 0) NULL," + String.fromCharCode(13)
					+"        [total] [decimal](12, 0) NULL," + String.fromCharCode(13)
					+"        [memo] [nvarchar](max) NULL," + String.fromCharCode(13)
					+"        [mon] [nvarchar](7) NULL," + String.fromCharCode(13)
					+"        [storeno] [nvarchar](15) NULL," + String.fromCharCode(13)
					+"        [store] [nvarchar](25) NULL," + String.fromCharCode(13)
					+"        [invono] [nvarchar](25) NULL," + String.fromCharCode(13)
					+"        [accno] [nvarchar](25) NULL," + String.fromCharCode(13)
					+"        [ordeno] [nvarchar](25) NULL," + String.fromCharCode(13)
					+"        [atax] [char](1) NULL," + String.fromCharCode(13)
					+"        [weight] [decimal](12, 0) NULL," + String.fromCharCode(13)
					+"        [floata] [decimal](10, 5) NULL," + String.fromCharCode(13)
					+"        [carno] [nvarchar](18) NULL," + String.fromCharCode(13)
					+"        [car] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [carno2] [nvarchar](18) NULL," + String.fromCharCode(13)
					+"        [mount] [decimal](9, 0) NULL," + String.fromCharCode(13)
					+"        [price] [decimal](11, 3) NULL," + String.fromCharCode(13)
					+"        [tranmoney] [decimal](8, 0) NULL," + String.fromCharCode(13)
					+"        [paytype] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [worker] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [trantype] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [aacc] [char](1) NULL," + String.fromCharCode(13)
					+"        [cno] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [acomp] [nvarchar](90) NULL," + String.fromCharCode(13)
					+"        [coin] [nvarchar](10) NULL," + String.fromCharCode(13)
					+"        [worker2] [nvarchar](50) NULL," + String.fromCharCode(13)
					+"        [stype] [nvarchar](10) NULL," + String.fromCharCode(13)
					+"        [zipname] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [zipcode] [nvarchar](16) NULL," + String.fromCharCode(13)
					+"        [taxtype] [nvarchar](2) NULL," + String.fromCharCode(13)
					+"        [partno] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [part] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [part2] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [partno2] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [salesno2] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [sales2] [nvarchar](20) NULL," + String.fromCharCode(13)
					+"        [pay] [nvarchar](10) NULL," + String.fromCharCode(13)
					+"        [kind] [nvarchar](14) NULL," + String.fromCharCode(13)
				 	+"        CONSTRAINT [PK_vcc"+year+"] PRIMARY KEY CLUSTERED "+ String.fromCharCode(13)
					+"        ("+ String.fromCharCode(13)
					+"            [noa] ASC"+ String.fromCharCode(13)
					+"        )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]"+ String.fromCharCode(13)
					+"    ) ON [PRIMARY]"+ String.fromCharCode(13)
					+"end"+ String.fromCharCode(13)
					
					+"if not exists(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE UPPER(TABLE_NAME)='VCCS"+year+"' )"+ String.fromCharCode(13)
					+"begin"+ String.fromCharCode(13)
					+"    CREATE TABLE [dbo].[vccs"+year+"]("+ String.fromCharCode(13)
					+"        [noa] [nvarchar](20) NOT NULL,"+ String.fromCharCode(13)
					+"        [noq] [nvarchar](5) NOT NULL,"+ String.fromCharCode(13)
					+"        [custno] [nvarchar](10) NULL,"+ String.fromCharCode(13)
					+"        [datea] [nvarchar](10) NULL,"+ String.fromCharCode(13)
					+"        [productno] [nvarchar](30) NULL,"+ String.fromCharCode(13)
					+"        [product] [nvarchar](60) NULL,"+ String.fromCharCode(13)
					+"        [spec] [nvarchar](50) NULL,"+ String.fromCharCode(13)
					+"        [unit] [nvarchar](8) NULL,"+ String.fromCharCode(13)
					+"        [price] [decimal](14, 3) NULL,"+ String.fromCharCode(13)
					+"        [mount] [decimal](15, 3) NULL,"+ String.fromCharCode(13)
					+"        [total] [decimal](10, 0) NULL,"+ String.fromCharCode(13)
					+"        [ordeno] [nvarchar](15) NULL,"+ String.fromCharCode(13)
					+"        [mon] [nvarchar](7) NULL,"+ String.fromCharCode(13)
					+"        [storeno] [nvarchar](5) NULL,"+ String.fromCharCode(13)
					+"        [no2] [nvarchar](3) NULL,"+ String.fromCharCode(13)
					+"        [weight] [decimal](11, 2) NULL,"+ String.fromCharCode(13)
					+"        [sprice] [decimal](14, 3) NULL,"+ String.fromCharCode(13)
					+"        [uno] [nvarchar](25) NULL,"+ String.fromCharCode(13)
					+"        [cno] [nvarchar](20) NULL,"+ String.fromCharCode(13)
					+"        [memo] [nvarchar](max) NULL,"+ String.fromCharCode(13)
					+"        [dime] [decimal](7, 3) NULL,"+ String.fromCharCode(13)
					+"        [width] [decimal](7, 2) NULL,"+ String.fromCharCode(13)
					+"        [lengthb] [decimal](8, 2) NULL,"+ String.fromCharCode(13)
					+"        [style] [nvarchar](7) NULL,"+ String.fromCharCode(13)
					+"        [size] [nvarchar](55) NULL,"+ String.fromCharCode(13)
					+"        [gweight] [decimal](11, 2) NULL,"+ String.fromCharCode(13)
					+"        [store] [nvarchar](30) NULL,"+ String.fromCharCode(13)
					+"        [itemno] [nvarchar](30) NULL,"+ String.fromCharCode(13)
					+"        [item] [nvarchar](50) NULL,"+ String.fromCharCode(13)
					+"        [typea] [nvarchar](10) NULL,"+ String.fromCharCode(13)
					+"        [acc1] [nvarchar](20) NULL,"+ String.fromCharCode(13)
					+"        [acc2] [nvarchar](50) NULL,"+ String.fromCharCode(13)
					+"        [radius] [float] NULL,"+ String.fromCharCode(13)
					+"        [class] [nvarchar](30) NULL,"+ String.fromCharCode(13)
 					+"        CONSTRAINT [PK_vccs"+year+"] PRIMARY KEY NONCLUSTERED "+ String.fromCharCode(13)
					+"        ("+ String.fromCharCode(13)
					+"            [noa] ASC,"+ String.fromCharCode(13)
					+"            [noq] ASC"+ String.fromCharCode(13)
					+"        )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]"+ String.fromCharCode(13)
					+"    ) ON [PRIMARY]"+ String.fromCharCode(13)
					+"end"+ String.fromCharCode(13);
            }
            function view_vcc(year){
            	return "if not exists(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE UPPER(TABLE_NAME)='VIEW_VCC"+year+"' )"+ String.fromCharCode(13)
					+"begin"+ String.fromCharCode(13)
	            	+"    set @cmd=\"CREATE view [dbo].[view_vcc"+year+"]\""+ String.fromCharCode(13)
					+"    +\" as\""+ String.fromCharCode(13)
					+"    +\" select '"+(year-1)+"' accy,* from vcc"+(year-1)+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year)+"' accy,* from vcc"+year+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year+1)+"' accy,* from vcc"+(year+1)+"\""+ String.fromCharCode(13)
					+"end"+ String.fromCharCode(13)
					+"else"+ String.fromCharCode(13)
					+"begin"+ String.fromCharCode(13)
					+"    set @cmd=\"ALTER view [dbo].[view_vcc"+year+"]\""+ String.fromCharCode(13)
					+"    +\" as\""+ String.fromCharCode(13)
					+"    +\" select '"+(year-1)+"' accy,* from vcc"+(year-1)+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year)+"' accy,* from vcc"+year+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year+1)+"' accy,* from vcc"+(year+1)+"\""+ String.fromCharCode(13)
					+"end"+ String.fromCharCode(13)
					+"execute sp_executesql @cmd "+ String.fromCharCode(13)
					+"if not exists(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE UPPER(TABLE_NAME)='VIEW_VCCS"+year+"' )"+ String.fromCharCode(13)
					+"begin"+ String.fromCharCode(13)
	            	+"    set @cmd=\"CREATE view [dbo].[view_vccs"+year+"]\""+ String.fromCharCode(13)
					+"    +\" as\""+ String.fromCharCode(13)
					+"    +\" select '"+(year-1)+"' accy,* from vccs"+(year-1)+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year)+"' accy,* from vccs"+year+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year+1)+"' accy,* from vccs"+(year+1)+"\""+ String.fromCharCode(13)
					+"end"+ String.fromCharCode(13)
					+"else"+ String.fromCharCode(13)
					+"begin"+ String.fromCharCode(13)
					+"    set @cmd=\"ALTER view [dbo].[view_vccs"+year+"]\""+ String.fromCharCode(13)
					+"    +\" as\""+ String.fromCharCode(13)
					+"    +\" select '"+(year-1)+"' accy,* from vccs"+(year-1)+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year)+"' accy,* from vccs"+year+"\""+ String.fromCharCode(13)
					+"    +\" union all \""+ String.fromCharCode(13)
					+"    +\" select '"+(year+1)+"' accy,* from vccs"+(year+1)+"\""+ String.fromCharCode(13)
					+"end"+ String.fromCharCode(13)
					+"execute sp_executesql @cmd "+ String.fromCharCode(13);
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<input id="txtYear" style="width:200px;"/>
		<input id="btnRun" type="button" value="RUN"/>
		<a id="file"> SQL </a>
	</body>
</html>