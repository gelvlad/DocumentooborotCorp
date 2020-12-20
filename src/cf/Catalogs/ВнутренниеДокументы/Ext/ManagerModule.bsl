﻿
Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Макет = Справочники.ВнутренниеДокументы.ПолучитьМакет("Печать");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВнутренниеДокументы.Код КАК Код,
	|	ВнутренниеДокументы.Наименование КАК Наименование,
	|	ВнутренниеДокументы.Организация КАК Организация,
	|	ВнутренниеДокументы.Организация.ИНН КАК ИНН,
	|	ФИО.Фамилия AS Фамилия,
	|	ФИО.Имя AS Имя,
	|	ФИО.Отчество AS Отчество,
	|	ВнутренниеДокументы.Предметы.(
	|		НомерСтроки,
	|		Предмет
	|	)
	|ИЗ
	|	Справочник.ВнутренниеДокументы КАК ВнутренниеДокументы
	|	LEFT JOIN РегистрСведений.ФИО.СрезПоследних(&КонецПериода) AS ФИО
	|	ON ФИО.ФизическоеЛицо = ВнутренниеДокументы.Автор.Владелец.Руководитель.ФизическоеЛицо
	|ГДЕ
	|	ВнутренниеДокументы.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("КонецПериода", ТекущаяДата());
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьПредметыШапка = Макет.ПолучитьОбласть("ПредметыШапка");
	ОбластьПредметы = Макет.ПолучитьОбласть("Предметы");
	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ТабДок.Вывести(ОбластьПредметыШапка);
		ВыборкаПредметы = Выборка.Предметы.Выбрать();
		Пока ВыборкаПредметы.Следующий() Цикл
			ОбластьПредметы.Параметры.Заполнить(ВыборкаПредметы);
			ТабДок.Вывести(ОбластьПредметы, ВыборкаПредметы.Уровень());
		КонецЦикла;

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры
