object Form1: TForm1
  Left = 429
  Top = 247
  Caption = #30446#24405#26641#22797#21046
  ClientHeight = 342
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 60
    Height = 13
    Caption = #24320#22987#30340#30446#24405
  end
  object lbl1: TLabel
    Left = 8
    Top = 96
    Width = 84
    Height = 13
    Caption = #35201#25335#36125#30340#30446#24405#65306
  end
  object lbl2: TLabel
    Left = 184
    Top = 96
    Width = 84
    Height = 13
    Caption = #35201#23384#25918#30340#20301#32622#65306
  end
  object Memo1: TMemo
    Left = 358
    Top = 40
    Width = 241
    Height = 241
    Lines.Strings = (
      #22797#21046#30340#30446#24405#26377#65306)
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 366
    Top = 304
    Width = 75
    Height = 25
    Caption = #32467#26463
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 193
    Top = 309
    Width = 75
    Height = 25
    Caption = #24320#22987
    TabOrder = 2
    OnClick = Button2Click
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 120
    Width = 145
    Height = 19
    TabOrder = 3
    OnChange = DriveComboBox1Change
  end
  object DriveComboBox2: TDriveComboBox
    Left = 184
    Top = 120
    Width = 145
    Height = 19
    TabOrder = 4
    OnChange = DriveComboBox2Change
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 144
    Width = 145
    Height = 137
    TabOrder = 5
    OnChange = DirectoryListBox1Change
  end
  object DirectoryListBox2: TDirectoryListBox
    Left = 184
    Top = 144
    Width = 145
    Height = 137
    TabOrder = 6
  end
  object Edit1: TEdit
    Left = 8
    Top = 51
    Width = 321
    Height = 21
    TabOrder = 7
    Text = '.'
  end
end
