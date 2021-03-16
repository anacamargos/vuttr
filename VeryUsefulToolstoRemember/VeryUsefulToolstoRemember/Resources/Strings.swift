// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
// Custom template

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum AddNewTool {
    /// Adicionar nova ferramenta
    internal static var addNewToolTitle: String {
      L10n.tr("Localizable", "add_new_tool.add_new_tool_title")
    }
    /// Adicionar ferramenta
    internal static var addTool: String {
      L10n.tr("Localizable", "add_new_tool.add_tool")
    }
    /// Cancelar
    internal static var removeToolCancel: String {
      L10n.tr("Localizable", "add_new_tool.remove_tool_cancel")
    }
    /// Sim, remova
    internal static var removeToolConfirmation: String {
      L10n.tr("Localizable", "add_new_tool.remove_tool_confirmation")
    }
    /// Você tem certeza que deseja remover %@?
    internal static func removeToolDescription(_ p1: String) -> String {
      return L10n.tr("Localizable", "add_new_tool.remove_tool_description", p1)
    }
    /// Remover ferramenta
    internal static var removeToolTitle: String {
      L10n.tr("Localizable", "add_new_tool.remove_tool_title")
    }
    /// Campo obrigatório
    internal static var requiredField: String {
      L10n.tr("Localizable", "add_new_tool.required_field")
    }
    /// Tags
    internal static var tags: String {
      L10n.tr("Localizable", "add_new_tool.tags")
    }
    /// Descrição da ferramenta
    internal static var toolDescription: String {
      L10n.tr("Localizable", "add_new_tool.tool_description")
    }
    /// Link da ferramenta
    internal static var toolLink: String {
      L10n.tr("Localizable", "add_new_tool.tool_link")
    }
    /// Nome da ferramenta
    internal static var toolName: String {
      L10n.tr("Localizable", "add_new_tool.tool_name")
    }
  }

  internal enum Home {
    /// Você não adicionou nenhuma ferramenta... ainda!
    internal static var noRegisteredTools: String {
      L10n.tr("Localizable", "home.no_registered_tools")
    }
    /// Pesquisar
    internal static var search: String {
      L10n.tr("Localizable", "home.search")
    }
    /// vuttr
    internal static var vuttr: String {
      L10n.tr("Localizable", "home.vuttr")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = Bundle.main.localizedString(forKey: key, value: "", table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
