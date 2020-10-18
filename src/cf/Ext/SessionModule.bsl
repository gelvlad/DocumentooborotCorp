﻿Процедура УстановкаПараметровСеанса(ТребуемыеПараметры)
	ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	Пользователь = Справочники.Пользователи.НайтиПоНаименованию(ТекущийПользователь.Имя);
	Если Пользователь.Пустая() Тогда
		НовыйПользователь = Справочники.Пользователи.СоздатьЭлемент();
		НовыйПользователь.Наименование = ИмяПользователя();
		Для каждого Роль из ТекущийПользователь.Роли цикл
			Строка = НовыйПользователь.Роли.Добавить();
			Строка.Роль = Роль;
		КонецЦикла;
		НовыйПользователь.Записать();
		Пользователь = НовыйПользователь.Ссылка;
	КонецЕсли; 
	ПараметрыСеанса.ТекущийПользователь = Пользователь;
КонецПроцедуры