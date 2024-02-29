enum KeyEnum {
  None,
  Cancel,
  Back,
  Tab,
  LineFeed,
  Clear,
  Enter,
  Return,
  Pause,
  Capital,
  CapsLock,
  HangulMode,
  KanaMode,
  JunjaMode,
  FinalMode,
  HanjaMode,
  KanjiMode,
  Escape,
  ImeConvert,
  ImeNonConvert,
  ImeAccept,
  ImeModeChange,
  Space,
  PageUp,
  Prior,
  Next,
  PageDown,
  End,
  Home,
  Left,
  Up,
  Right,
  Down,
  Select,
  Print,
  Execute,
  PrintScreen,
  Snapshot,
  Insert,
  Delete,
  Help,
  D0,
  D1,
  D2,
  D3,
  D4,
  D5,
  D6,
  D7,
  D8,
  D9,
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
  K,
  L,
  M,
  N,
  O,
  P,
  Q,
  R,
  S,
  T,
  U,
  V,
  W,
  X,
  Y,
  Z,
  LWin,
  RWin,
  Apps,
  Sleep,
  NumPad0,
  NumPad1,
  NumPad2,
  NumPad3,
  NumPad4,
  NumPad5,
  NumPad6,
  NumPad7,
  NumPad8,
  NumPad9,
  Multiply,
  Add,
  Separator,
  Subtract,
  Decimal,
  Divide,
  F1,
  F2,
  F3,
  F4,
  F5,
  F6,
  F7,
  F8,
  F9,
  F10,
  F11,
  F12,
  F13,
  F14,
  F15,
  F16,
  F17,
  F18,
  F19,
  F20,
  F21,
  F22,
  F23,
  F24,
  NumLock,
  Scroll,
  LeftShift,
  RightShift,
  LeftCtrl,
  RightCtrl,
  LeftAlt,
  RightAlt,
  BrowserBack,
  BrowserForward,
  BrowserRefresh,
  BrowserStop,
  BrowserSearch,
  BrowserFavorites,
  BrowserHome,
  VolumeMute,
  VolumeDown,
  VolumeUp,
  MediaNextTrack,
  MediaPreviousTrack,
  MediaStop,
  MediaPlayPause,
  LaunchMail,
  SelectMedia,
  LaunchApplication1,
  LaunchApplication2,
  Oem1,
  OemSemicolon,
  OemPlus,
  OemComma,
  OemMinus,
  OemPeriod,
  Oem2,
  OemQuestion,
  Oem3,
  OemTilde,
  AbntC1,
  AbntC2,
  Oem4,
  OemOpenBrackets,
  Oem5,
  OemPipe,
  Oem6,
  OemCloseBrackets,
  Oem7,
  OemQuotes,
  Oem8,
  Oem102,
  OemBackslash,
  ImeProcessed,
  System,
  DbeAlphanumeric,
  OemAttn,
  DbeKatakana,
  OemFinish,
  DbeHiragana,
  OemCopy,
  DbeSbcsChar,
  OemAuto,
  DbeDbcsChar,
  OemEnlw,
  DbeRoman,
  OemBackTab,
  Attn,
  DbeNoRoman,
  CrSel,
  DbeEnterWordRegisterMode,
  DbeEnterImeConfigureMode,
  ExSel,
  DbeFlushString,
  EraseEof,
  DbeCodeInput,
  Play,
  DbeNoCodeInput,
  Zoom,
  DbeDetermineString,
  NoName,
  DbeEnterDialogConversionMode,
  Pa1,
  OemClear,
  DeadCharProcessed,
}

// key enum value extension

extension KeyEnumExtension on KeyEnum {
  int get value {
    switch (this) {
      case KeyEnum.None:
        return 0x0000;
      case KeyEnum.Cancel:
        return 0x0003;
      case KeyEnum.Back:
        return 0x0008;
      case KeyEnum.Tab:
        return 0x0009;
      case KeyEnum.LineFeed:
        return 0x000A;
      case KeyEnum.Clear:
        return 0x000C;
      case KeyEnum.Enter:
        return 0x000D;
      case KeyEnum.Return:
        return 0x000D;
      case KeyEnum.Pause:
        return 0x0013;
      case KeyEnum.Capital:
        return 0x0014;
      case KeyEnum.CapsLock:
        return 0x0014;
      case KeyEnum.HangulMode:
        return 0x0015;
      case KeyEnum.KanaMode:
        return 0x0015;
      case KeyEnum.JunjaMode:
        return 0x0017;
      case KeyEnum.FinalMode:
        return 0x0018;
      case KeyEnum.HanjaMode:
        return 0x0019;
      case KeyEnum.KanjiMode:
        return 0x0019;
      case KeyEnum.Escape:
        return 0x001B;
      case KeyEnum.ImeConvert:
        return 0x001C;
      case KeyEnum.ImeNonConvert:
        return 0x001D;
      case KeyEnum.ImeAccept:
        return 0x001E;
      case KeyEnum.ImeModeChange:
        return 0x001F;
      case KeyEnum.Space:
        return 0x0020;
      case KeyEnum.PageUp:
        return 0x0021;
      case KeyEnum.Prior:
        return 0x0021;
      case KeyEnum.Next:
        return 0x0022;
      case KeyEnum.PageDown:
        return 0x0022;
      case KeyEnum.End:
        return 0x0023;
      case KeyEnum.Home:
        return 0x0024;
      case KeyEnum.Left:
        return 0x0025;
      case KeyEnum.Up:
        return 0x0026;
      case KeyEnum.Right:
        return 0x0027;
      case KeyEnum.Down:
        return 0x0028;
      case KeyEnum.Select:
        return 0x0029;
      case KeyEnum.Print:
        return 0x002A;
      case KeyEnum.Execute:
        return 0x002B;
      case KeyEnum.PrintScreen:
        return 0x002C;
      case KeyEnum.Snapshot:
        return 0x002C;
      case KeyEnum.Insert:
        return 0x002D;
      case KeyEnum.Delete:
        return 0x002E;
      case KeyEnum.Help:
        return 0x002F;
      case KeyEnum.D0:
        return 0x0030;
      case KeyEnum.D1:
        return 0x0031;
      case KeyEnum.D2:
        return 0x0032;
      case KeyEnum.D3:
        return 0x0033;
      case KeyEnum.D4:
        return 0x0034;
      case KeyEnum.D5:
        return 0x0035;
      case KeyEnum.D6:
        return 0x0036;
      case KeyEnum.D7:
        return 0x0037;
      case KeyEnum.D8:
        return 0x0038;
      case KeyEnum.D9:
        return 0x0039;
      case KeyEnum.A:
        return 0x0041;
      case KeyEnum.B:
        return 0x0042;
      case KeyEnum.C:
        return 0x0043;
      case KeyEnum.D:
        return 0x0044;
      case KeyEnum.E:
        return 0x0045;
      case KeyEnum.F:
        return 0x0046;
      case KeyEnum.G:
        return 0x0047;
      case KeyEnum.H:
        return 0x0048;
      case KeyEnum.I:
        return 0x0049;
      case KeyEnum.J:
        return 0x004A;
      case KeyEnum.K:
        return 0x004B;
      case KeyEnum.L:
        return 0x004C;
      case KeyEnum.M:
        return 0x004D;
      case KeyEnum.N:
        return 0x004E;
      case KeyEnum.O:
        return 0x004F;
      case KeyEnum.P:
        return 0x0050;
      case KeyEnum.Q:
        return 0x0051;
      case KeyEnum.R:
        return 0x0052;
      case KeyEnum.S:
        return 0x0053;
      case KeyEnum.T:
        return 0x0054;
      case KeyEnum.U:
        return 0x0055;
      case KeyEnum.V:
        return 0x0056;
      case KeyEnum.W:
        return 0x0057;
      case KeyEnum.X:
        return 0x0058;
      case KeyEnum.Y:
        return 0x0059;
      case KeyEnum.Z:
        return 0x005A;
      case KeyEnum.LWin:
        return 0x005B;
      case KeyEnum.RWin:
        return 0x005C;
      case KeyEnum.Apps:
        return 0x005D;
      case KeyEnum.Sleep:
        return 0x005F;
      case KeyEnum.NumPad0:
        return 0x0060;
      case KeyEnum.NumPad1:
        return 0x0061;
      case KeyEnum.NumPad2:
        return 0x0062;
      case KeyEnum.NumPad3:
        return 0x0063;
      case KeyEnum.NumPad4:
        return 0x0064;
      case KeyEnum.NumPad5:
        return 0x0065;
      case KeyEnum.NumPad6:
        return 0x0066;
      case KeyEnum.NumPad7:
        return 0x0067;
      case KeyEnum.NumPad8:
        return 0x0068;
      case KeyEnum.NumPad9:
        return 0x0069;
      case KeyEnum.Multiply:
        return 0x006A;
      case KeyEnum.Add:
        return 0x006B;
      case KeyEnum.Separator:
        return 0x006C;
      case KeyEnum.Subtract:
        return 0x006D;
      case KeyEnum.Decimal:
        return 0x006E;
      case KeyEnum.Divide:
        return 0x006F;
      case KeyEnum.F1:
        return 0x0070;
      case KeyEnum.F2:
        return 0x0071;
      case KeyEnum.F3:
        return 0x0072;
      case KeyEnum.F4:
        return 0x0073;
      case KeyEnum.F5:
        return 0x0074;
      case KeyEnum.F6:
        return 0x0075;
      case KeyEnum.F7:
        return 0x0076;
      case KeyEnum.F8:
        return 0x0077;
      case KeyEnum.F9:
        return 0x0078;
      case KeyEnum.F10:
        return 0x0079;
      case KeyEnum.F11:
        return 0x007A;
      case KeyEnum.F12:
        return 0x007B;
      case KeyEnum.F13:
        return 0x007C;
      case KeyEnum.F14:
        return 0x007D;
      case KeyEnum.F15:
        return 0x007E;
      case KeyEnum.F16:
        return 0x007F;
      case KeyEnum.F17:
        return 0x0080;
      case KeyEnum.F18:
        return 0x0081;
      case KeyEnum.F19:
        return 0x0082;
      case KeyEnum.F20:
        return 0x0083;
      case KeyEnum.F21:
        return 0x0084;
      case KeyEnum.F22:
        return 0x0085;
      case KeyEnum.F23:
        return 0x0086;
      case KeyEnum.F24:
        return 0x0087;
      case KeyEnum.NumLock:
        return 0x0090;
      case KeyEnum.Scroll:
        return 0x0091;
      case KeyEnum.LeftShift:
        return 0xA0;
      case KeyEnum.RightShift:
        return 0xA1;
      case KeyEnum.LeftCtrl:
        return 0xA2;
      case KeyEnum.RightCtrl:
        return 0xA3;
      case KeyEnum.LeftAlt:
        return 0xA4;
      case KeyEnum.RightAlt:
        return 0xA5;
      case KeyEnum.BrowserBack:
        return 0xA6;
      case KeyEnum.BrowserForward:
        return 0xA7;
      case KeyEnum.BrowserRefresh:
        return 0xA8;
      case KeyEnum.BrowserStop:
        return 0xA9;
      case KeyEnum.BrowserSearch:
        return 0xAA;
      case KeyEnum.BrowserFavorites:
        return 0xAB;
      case KeyEnum.BrowserHome:
        return 0xAC;
      case KeyEnum.VolumeMute:
        return 0xAD;
      case KeyEnum.VolumeDown:
        return 0xAE;
      case KeyEnum.VolumeUp:
        return 0xAF;
      case KeyEnum.MediaNextTrack:
        return 0xB0;
      case KeyEnum.MediaPreviousTrack:
        return 0xB1;
      case KeyEnum.MediaStop:
        return 0xB2;
      case KeyEnum.MediaPlayPause:
        return 0xB3;
      case KeyEnum.LaunchMail:
        return 0xB4;
      case KeyEnum.SelectMedia:
        return 0xB5;
      case KeyEnum.LaunchApplication1:
        return 0xB6;
      case KeyEnum.LaunchApplication2:
        return 0xB7;
      case KeyEnum.Oem1:
        return 0xBA;
      case KeyEnum.OemSemicolon:
        return 0xBA;
      case KeyEnum.OemPlus:
        return 0xBB;
      case KeyEnum.OemComma:
        return 0xBC;
      case KeyEnum.OemMinus:
        return 0xBD;
      case KeyEnum.OemPeriod:
        return 0xBE;
      case KeyEnum.Oem2:
        return 0xBF;
      case KeyEnum.OemQuestion:
        return 0xBF;
      case KeyEnum.Oem3:
        return 0xC0;
      case KeyEnum.OemTilde:
        return 0xC0;
      case KeyEnum.AbntC1:
        return 0xC1;
      case KeyEnum.AbntC2:
        return 0xC2;
      case KeyEnum.Oem4:
        return 0xDB;
      case KeyEnum.OemOpenBrackets:
        return 0xDB;
      case KeyEnum.Oem5:
        return 0xDC;
      case KeyEnum.OemPipe:
        return 0xDC;
      case KeyEnum.Oem6:
        return 0xDD;
      case KeyEnum.OemCloseBrackets:
        return 0xDD;
      case KeyEnum.Oem7:
        return 0xDE;
      case KeyEnum.OemQuotes:
        return 0xDE;
      case KeyEnum.Oem8:
        return 0xDF;
      case KeyEnum.Oem102:
        return 0xE2;
      case KeyEnum.OemBackslash:
        return 0xE2;
      case KeyEnum.ImeProcessed:
        return 0xE5;
      case KeyEnum.System:
        return 0xE7;
      case KeyEnum.DbeAlphanumeric:
        return 0x0F0;
      case KeyEnum.OemAttn:
        return 0xF0;
      case KeyEnum.DbeKatakana:
        return 0xF1;
      case KeyEnum.OemFinish:
        return 0xF1;
      case KeyEnum.DbeHiragana:
        return 0xF2;
      case KeyEnum.OemCopy:
        return 0xF2;
      case KeyEnum.DbeSbcsChar:
        return 0xF3;
      case KeyEnum.OemAuto:
        return 0xF3;
      case KeyEnum.DbeDbcsChar:
        return 0xF4;
      case KeyEnum.OemEnlw:
        return 0xF4;
      case KeyEnum.DbeRoman:
        return 0xF5;
      case KeyEnum.OemBackTab:
        return 0xF5;
      case KeyEnum.Attn:
        return 0xF6;
      case KeyEnum.DbeNoRoman:
        return 0xF6;
      case KeyEnum.CrSel:
        return 0xF7;
      case KeyEnum.DbeEnterWordRegisterMode:
        return 0xF7;
      case KeyEnum.DbeEnterImeConfigureMode:
        return 0xF8;
      case KeyEnum.ExSel:
        return 0xF8;
      case KeyEnum.DbeFlushString:
        return 0xF9;
      case KeyEnum.EraseEof:
        return 0xF9;
      case KeyEnum.DbeCodeInput:
        return 0xFA;
      case KeyEnum.Play:
        return 0xFA;
      case KeyEnum.DbeNoCodeInput:
        return 0xFB;
      case KeyEnum.Zoom:
        return 0xFB;
      case KeyEnum.DbeDetermineString:
        return 0xFC;
      case KeyEnum.NoName:
        return 0xFC;
      case KeyEnum.DbeEnterDialogConversionMode:
        return 0xFD;
      case KeyEnum.Pa1:
        return 0xFD;
      case KeyEnum.OemClear:
        return 0xFE;
      case KeyEnum.DeadCharProcessed:
        return 0xFE;
      default:
        return 0x0000;
    }
  }
}
