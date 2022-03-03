//
//  EditDetailerSwipeMenu.swift
//
// Copyright 2022 FlowAllocator LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct EditDetailerSwipeMenu<Element>: ViewModifier
    where Element: Identifiable
{
    public typealias CanEdit = (Element) -> Bool
    public typealias CanDelete = (Element) -> Bool
    public typealias OnDelete = (Element.ID) -> Void

    private let element: Element
    @Binding private var toEdit: Element?
    private let canEdit: CanEdit
    private let canDelete: CanDelete
    private let onDelete: OnDelete?

    public init(_ element: Element,
                _ toEdit: Binding<Element?>,
                _ canEdit: @escaping CanEdit = { _ in true },
                _ canDelete: @escaping CanDelete = { _ in true },
                _ onDelete: OnDelete? = nil)
    {
        self.element = element
        _toEdit = toEdit
        self.canEdit = canEdit
        self.canDelete = canDelete
        self.onDelete = onDelete
    }

    // convenience to unwrap bound element
    public init(_ element: Binding<Element>,
                _ toEdit: Binding<Element?>,
                _ canEdit: @escaping CanEdit = { _ in true },
                _ canDelete: @escaping CanDelete = { _ in true },
                _ onDelete: OnDelete? = nil)
    {
        self.init(element.wrappedValue,
                  toEdit,
                  canEdit,
                  canDelete,
                  onDelete)
    }

    private var isDeleteAvailable: Bool {
        onDelete != nil
    }

    public func body(content: Content) -> some View {
        content
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                DetailerEditButton(element: element, canEdit: canEdit) { toEdit = $0 }
                    .tint(.accentColor)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                // NOTE if no delete handler, hide menu item entirely
                if isDeleteAvailable {
                    DetailerDeleteButton(element: element, canDelete: canDelete, onDelete: onDelete)
                        .tint(.red)
                }
            }
    }
}
