unit NamedVolumManagerMainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Buttons, DockerAPI;

type

  { TNamedVolumManagerMain }

  TNamedVolumManagerMain = class(TForm)
    Clone: TBitBtn;
    CreateBackup: TBitBtn;
    Remove: TBitBtn;
    Ok: TBitBtn;
    NamedVolumLabel: TLabel;
    NamedVolumeTree: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure OkClick(Sender: TObject);
  private

  public

  end;

var
  NamedVolumManagerMain: TNamedVolumManagerMain;

implementation

{$R *.lfm}

{ TNamedVolumManagerMain }

procedure TNamedVolumManagerMain.FormCreate(Sender: TObject);
var i:integer;
begin
  if  NOT DockerAPI.available() Then
  begin
    ShowMessage('Docker-Desktop must expose the Daemon!');
    Application.Terminate;
  end
  else
  begin
    for i := 1 to DockerAPI.VolumeCount do
    begin
      NamedVolumeTree.Items.AddChildFirst(nil,inttostr(i));
    end;
  end;
end;

procedure TNamedVolumManagerMain.OkClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

