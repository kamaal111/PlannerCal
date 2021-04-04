//
//  ScrollableTextView.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import SwiftUI

#if os(macOS)
struct ScrollableTextView: NSViewRepresentable {
    @Binding var text: String

    init(text: Binding<String>) {
        self._text = text
    }

    func makeNSView(context: Context) -> NSViewType {
        let scrollableTextView = NSTextView.scrollableTextView()
        if let textView = scrollableTextView.documentView as? NSTextView {
            textView.isSelectable = true
            textView.font = NSFont.preferredFont(forTextStyle: .body, options: [:])
            textView.delegate = context.coordinator
        }
        return scrollableTextView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var text: Binding<String>

        init(_ text: Binding<String>) {
            self.text = text
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView,
                  let textValue = textView.textStorage?.string else { return }
            self.text.wrappedValue = textValue
        }
    }

    typealias NSViewType = NSScrollView
}
#endif

#if os(iOS)
struct ScrollableTextView: UIViewRepresentable {
    @Binding var text: String

    init(text: Binding<String>) {
        self._text = text
    }

    func makeUIView(context: Context) -> UIViewType {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.systemGray4
        return textView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>

        init(_ text: Binding<String>) {
            self.text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            guard let textValue = textView.text else { return }
            self.text.wrappedValue = textValue
        }
    }

    typealias UIViewType = UITextView
}
#endif

struct ScrollableTextView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollableTextView(text: .constant("Such a long text"))
                .padding(.all, 40)
                .previewLayout(.sizeThatFits)
            ZStack {
                Color.black
                ScrollableTextView(text: .constant("Such a long text"))
                    .padding(.all, 40)
            }
            .previewLayout(.sizeThatFits)
            .colorScheme(.dark)
        }
    }
}
