DECLARE @nvarchar NVARCHAR(MAX) = N'
<Manufacturer Name="Lenovo">
  <Product Name="ThinkPad E460">
    <Model Name="20ETS03100">
      <CPU>i7-6500U</CPU>
      <Memory>16</Memory>
      <SSD>256</SSD>
    </Model>
    <Model Name="20ETS02W00">
      <CPU>i5-6200U</CPU>
      <Memory>8</Memory>
      <HDD>1000</HDD>
    </Model>
    <Model Name="20ETS02V00">
      <CPU>i5-6200U</CPU>
      <Memory>4</Memory>
      <HDD>500</HDD>
    </Model>
  </Product>
</Manufacturer>'

DECLARE @nvarchar_d NVARCHAR(MAX) = N'<Manufacturer Name="Lenovo"><Product Name="ThinkPad E460"><Model Name="20ETS03100"><CPU>i7-6500U</CPU><Memory>16</Memory><SSD>256</SSD></Model><Model Name="20ETS02W00"><CPU>i5-6200U</CPU><Memory>8</Memory><HDD>1000</HDD></Model><Model Name="20ETS02V00"><CPU>i5-6200U</CPU><Memory>4</Memory><HDD>500</HDD></Model></Product></Manufacturer>'

DECLARE @xml XML = @nvarchar
      , @varchar VARCHAR(MAX) = @nvarchar
      , @xml_d XML = @nvarchar_d
      , @varchar_d VARCHAR(MAX) = @nvarchar_d

SELECT *
FROM (
    VALUES ('NVARCHAR', DATALENGTH(@nvarchar), DATALENGTH(@nvarchar_d))
         , ('VARCHAR',  DATALENGTH(@varchar),  DATALENGTH(@varchar_d))
         , ('XML',      DATALENGTH(@xml),      DATALENGTH(@xml_d))
) t(DataType, Delimeters, NoDelimeters)