//
//  EditDetailerContextMenu.swift
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

public struct EditDetailerContextMenu<Element>: ViewModifier
{
    public typealias CanEdit = (Element) -> Bool
    public typealias CanDelete = (Element) -> Bool
    public typealias OnDelete = (Element) -> Void
    public typealias OnEdit = (Element) -> Void

    private let element: Element
    private let canDelete: CanDelete
    private let onDelete: OnDelete?
    private let canEdit: CanEdit
    private let onEdit: OnEdit

    public init(_ element: Element,
                canDelete: @escaping CanDelete = { _ in true },
                onDelete: OnDelete? = nil,
                canEdit: @escaping CanEdit = { _ in true },
                onEdit: @escaping OnEdit)
    {
        self.element = element
        self.canDelete = canDelete
        self.onDelete = onDelete
        self.canEdit = canEdit
        self.onEdit = onEdit
    }

    private var isDeleteAvailable: Bool {
        onDelete != nil
    }

    public func body(content: Content) -> some View {
        content
            .contextMenu {
                DetailerEditButton(element: element, canEdit: canEdit) { onEdit($0) }
                
                // NOTE if no delete handler, hide menu item entirely
                if isDeleteAvailable {
                    Divider()
                    DetailerDeleteButton(element: element, canDelete: canDelete, onDelete: onDelete)
                }
            }
    }
}
