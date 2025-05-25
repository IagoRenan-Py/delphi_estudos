unit View.Cidades.Cadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Herancas.Cadastrar, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Model.Cidades.DM, Vcl.DBCtrls,
  Vcl.Mask, RTTI.FieldName;

type
  TViewCidadesCadastrar = class(TViewHerancasCadastrar)
    lbl: TLabel;
    edtCodigo: TDBEdit;
    lbl1: TLabel;

    [FieldName('NOME')]
    edtNome: TDBEdit;

    lbl2: TLabel;
    lbl3: TLabel;

    [FieldName('CODIGO_IBGE')]
    edtCodigoIBGE: TDBEdit;

    [FieldName('UF')]
    cbxUF: TDBComboBox;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    { Private declarations }
  public

    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Exceptions.FieldName,
  Utils;

procedure TViewCidadesCadastrar.btnGravarClick(Sender: TObject);
begin
  try
    DS_.DataSet.Post;
  except
    on E: ExceptionsFieldName do
      TUtils.TratarExceptionsFieldName(Self, E);
  end;

  inherited;
end;

procedure TViewCidadesCadastrar.FormShow(Sender: TObject);
begin
  inherited;

  ModelCidadesDM.CadastrarGet(inherited IdRegistroAlterar);

  if(DS_.DataSet.IsEmpty)then
    DS_.DataSet.Append
  else
    DS_.DataSet.Edit;

  edtNome.SetFocus;
end;

end.
