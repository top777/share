unit Unit1;

interface
{$WARN UNIT_PLATFORM OFF}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Types, IOUtils, FileCtrl;
type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    DriveComboBox1: TDriveComboBox;
    DriveComboBox2: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    DirectoryListBox2: TDirectoryListBox;
    Edit1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure DriveComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
  private
    procedure ListFiless(FilePath: string);
    procedure CreatDirs(DirName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  constr, FilePath, DirName: string;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  application.terminate;
end;

procedure TForm1.Button2Click(Sender: TObject);

begin
//memo初始化
  Memo1.Clear;
  Memo1.Lines.Add('复制的目录为：');
//判断是否根目录
  if DirectoryListBox2.Directory = DirectoryListBox2.Drive + ':\' then
    FilePath := DirectoryListBox2.Drive + ':'
  else FilePath := DirectoryListBox2.Directory;
  constr := DirectoryListBox1.Directory;
//调用子程序建立目录树
  CreatDirs(constr);
end;

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
  Edit1.Text := DirectoryListBox1.Directory;
end;

procedure TForm1.DriveComboBox1Change(Sender: TObject);
begin
  DirectoryListBox1.Drive := DriveComboBox1.Drive
end;

procedure TForm1.DriveComboBox2Change(Sender: TObject);
begin
  DirectoryListBox2.Drive := DriveComboBox2.Drive
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.BringToFront;
  edit1.ReadOnly := True;
end;


procedure TForm1.ListFiless(FilePath: string);
var
  FileList: TStringDynArray;
  FileName: string;
begin
  // 获取当前路径下的所有文件
  FileList := TDirectory.GetFiles(FilePath);
  //遍历数组，获取文件信息
  for FileName in FileList do begin
    Self.Memo1.Lines.Add(FileName);
  end;
end;

procedure TForm1.CreatDirs(DirName: string);
var
  DirList: TStringDynArray;
  Name, strPath: string;
  strs: TStrings;
  i: Integer;

begin
//定义起始目录路径，注意起始目录和存放位置不要有重叠，否则会形成循环
  strPath := FilePath;
  strs := TStringList.Create;
  strs.StrictDelimiter := True; //屏蔽空格为分隔符
  strs.Delimiter := '\';
  strs.DelimitedText := DirName;
  for i := 1 to Strs.Count - 1 do
    strPath := strPath + '\' + strs[i];
   // 获取某个路径下的所有文件夹
  if strPath = DirectoryListBox2.Drive + ':\' then
    Self.Memo1.Lines.Add('根目录跳过')
  else
  begin
  //在memo中显示拷贝的目录并创建目录
    Self.Memo1.Lines.Add(strPath);
    ForceDirectories(strPath);
  end;
  DirList := TDirectory.GetDirectories(DirName);
  // 遍历，获取每一个文件夹(路径)
  for Name in DirList do begin
    CreatDirs(Name);
  end;

end;


end.

