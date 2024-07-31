VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "目录树拷贝"
   ClientHeight    =   5160
   ClientLeft      =   105
   ClientTop       =   435
   ClientWidth     =   9135
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5160
   ScaleWidth      =   9135
   StartUpPosition =   3  '窗口缺省
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   9
      Text            =   "Form1.frx":0000
      Top             =   1800
      Width           =   2175
   End
   Begin VB.ListBox List1 
      Height          =   1680
      ItemData        =   "Form1.frx":0009
      Left            =   1320
      List            =   "Form1.frx":0010
      TabIndex        =   8
      Top             =   2520
      Width           =   6015
   End
   Begin VB.DirListBox Dir2 
      Height          =   1560
      Left            =   5880
      TabIndex        =   7
      Top             =   720
      Width           =   3135
   End
   Begin VB.DriveListBox Drive2 
      Height          =   300
      Left            =   5880
      TabIndex        =   6
      Top             =   360
      Width           =   1695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "退出"
      Height          =   495
      Left            =   5280
      TabIndex        =   5
      Top             =   4440
      Width           =   1455
   End
   Begin VB.DirListBox Dir1 
      Height          =   1560
      Left            =   2520
      TabIndex        =   4
      Top             =   720
      Width           =   3135
   End
   Begin VB.DriveListBox Drive1 
      Height          =   300
      Left            =   2520
      TabIndex        =   3
      Top             =   360
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Text            =   "Form1.frx":0024
      Top             =   840
      Width           =   2175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "执行"
      Height          =   495
      Left            =   2160
      TabIndex        =   1
      Top             =   4440
      Width           =   1335
   End
   Begin VB.Label Label3 
      Caption         =   "拷贝到："
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   1440
      Width           =   1095
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "保存位置"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   12
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   7680
      TabIndex        =   11
      Top             =   240
      Width           =   1335
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Caption         =   "目标文件夹"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   12
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3960
      TabIndex        =   10
      Top             =   240
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "将以下目录："
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   1575
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim CurFolder As String, fstPath As String
Private Declare Function MakeSureDirectoryPathExists Lib "imagehlp.dll" (ByVal DirPath As String) As Long
Private Sub Command1_Click()
  '列表框和文本框初始化
  List1.Clear
  Text2.Text = ""
  CurFolder = ""
  Text1.Text = Dir1.Path
  '确定是否根目录
  If Len(Dir1.Path) = 3 Then
     Text2.Text = Dir2.Path
  Else:
     MkPath (Dir1.Path)
     Text2.Text = CurFolder
     List1.AddItem Text2.Text
     MakeSureDirectoryPathExists Text2.Text
  End If

  '递归目录
  getAll (Dir1.Path)
End Sub

Private Sub Command2_Click()
  Unload Me
  End
End Sub


Private Sub Drive1_Change()
  Dir1.Path = Drive1.Drive
End Sub

Private Sub Drive2_Change()
  Dir2.Path = Drive2.Drive
End Sub

Function getAll(rootF)
  On Error Resume Next
  Dim fso As Object, folder As Object, subfolder As Object, file As Object
  Set fso = CreateObject("scripting.filesystemobject") '创建FSO对象
  Set folder = fso.getfolder(rootF) '得到文件夹对象

  For Each subfolder In folder.SubFolders '遍历子文件夹
    Call MkPath(subfolder)
    List1.AddItem CurFolder
    List1.Refresh
    '建立目录
    MakeSureDirectoryPathExists CurFolder
   ''生成零字节文本来占位
    'Open CurFolder & "\readme.txt" For Output As #1
    'Close #1
    Call getAll(subfolder) '递归,查找该文件夹的子文件夹
  Next
  Set fso = Nothing
  Set folder = Nothing
  Set fso = Nothing
End Function

Function MkPath(ByVal sPath As String)
'拆分初始目录，去掉驱动符号并将该路径嫁接到目标目录后面
  Dim i As Long
  Dim Splits() As String

  Splits = Split(sPath, "\")
  If Len(Dir2.Path) = 3 Then
     CurFolder = Dir2.Path
  Else:
     CurFolder = Dir2.Path & "\"
  End If
  For i = 1 To UBound(Splits)
    CurFolder = CurFolder & Splits(i) & "\"
  Next i
End Function

