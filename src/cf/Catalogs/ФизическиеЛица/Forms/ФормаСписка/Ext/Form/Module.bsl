﻿
&НаКлиенте
Процедура ДатаОтбораФИОПриИзменении(Элемент)
	Список.Параметры.УстановитьЗначениеПараметра("КонецПериода", ДатаОтбора);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ДатаОтбора = ТекущаяДата();
	ДатаОтбораФИОПриИзменении(ДатаОтбора);
КонецПроцедуры
