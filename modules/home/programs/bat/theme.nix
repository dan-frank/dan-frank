scheme:
let
  c = scheme.palette;
in
''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>author</key>
        <string>Template: Chris Kempson, Scheme: Base16</string>
        <key>name</key>
        <string>Base16</string>
        <key>colorSpaceName</key>
        <string>sRGB</string>
        <key>settings</key>
        <array>
            <dict>
                <key>settings</key>
                <dict>
                    <key>background</key>
                    <string>#${c.base00}</string>
                    <key>caret</key>
                    <string>#${c.base05}</string>
                    <key>foreground</key>
                    <string>#${c.base05}</string>
                    <key>invisibles</key>
                    <string>#${c.base03}</string>
                    <key>lineHighlight</key>
                    <string>#${c.base03}</string>
                    <key>selection</key>
                    <string>#${c.base02}</string>
                    <key>gutter</key>
                    <string>#${c.base01}</string>
                    <key>gutterForeground</key>
                    <string>#${c.base03}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Text</string>
                <key>scope</key>
                <string>variable.parameter.function</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base05}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Comments</string>
                <key>scope</key>
                <string>comment, punctuation.definition.comment</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base03}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Punctuation</string>
                <key>scope</key>
                <string>punctuation.definition.string, punctuation.definition.variable, punctuation.definition.string, punctuation.definition.parameters, punctuation.definition.string, punctuation.definition.array</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base05}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Delimiters</string>
                <key>scope</key>
                <string>none</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base05}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Operators</string>
                <key>scope</key>
                <string>keyword.operator</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base05}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Keywords</string>
                <key>scope</key>
                <string>keyword</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0E}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Variables</string>
                <key>scope</key>
                <string>variable</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base05}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Functions</string>
                <key>scope</key>
                <string>entity.name.function, meta.require, support.function.any-method</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0D}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Labels</string>
                <key>scope</key>
                <string>entity.name.label</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0F}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Classes</string>
                <key>scope</key>
                <string>support.class, entity.name.class, entity.name.type.class</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0A}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Classes</string>
                <key>scope</key>
                <string>meta.class</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base07}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Methods</string>
                <key>scope</key>
                <string>keyword.other.special-method</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0D}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Storage</string>
                <key>scope</key>
                <string>storage</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0E}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Support</string>
                <key>scope</key>
                <string>support.function</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0C}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Strings, Inherited Class</string>
                <key>scope</key>
                <string>string, constant.other.symbol, entity.other.inherited-class</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0B}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Integers</string>
                <key>scope</key>
                <string>constant.numeric</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Floats</string>
                <key>scope</key>
                <string>none</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Boolean</string>
                <key>scope</key>
                <string>none</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Constants</string>
                <key>scope</key>
                <string>constant</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Tags</string>
                <key>scope</key>
                <string>entity.name.tag</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base08}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Attributes</string>
                <key>scope</key>
                <string>entity.other.attribute-name</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Attribute IDs</string>
                <key>scope</key>
                <string>entity.other.attribute-name.id, punctuation.definition.entity</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0D}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Selector</string>
                <key>scope</key>
                <string>meta.selector</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0E}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Values</string>
                <key>scope</key>
                <string>none</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Headings</string>
                <key>scope</key>
                <string>markup.heading punctuation.definition.heading, entity.name.section</string>
                <key>settings</key>
                <dict>
                    <key>fontStyle</key>
                    <string></string>
                    <key>foreground</key>
                    <string>#${c.base0D}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Units</string>
                <key>scope</key>
                <string>keyword.other.unit</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Bold</string>
                <key>scope</key>
                <string>markup.bold, punctuation.definition.bold</string>
                <key>settings</key>
                <dict>
                    <key>fontStyle</key>
                    <string>bold</string>
                    <key>foreground</key>
                    <string>#${c.base0A}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Italic</string>
                <key>scope</key>
                <string>markup.italic, punctuation.definition.italic</string>
                <key>settings</key>
                <dict>
                    <key>fontStyle</key>
                    <string>italic</string>
                    <key>foreground</key>
                    <string>#${c.base0E}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Code</string>
                <key>scope</key>
                <string>markup.raw.inline</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0B}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Link Text</string>
                <key>scope</key>
                <string>string.other.link, punctuation.definition.string.end.markdown, punctuation.definition.string.begin.markdown</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base08}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Link Url</string>
                <key>scope</key>
                <string>meta.link</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Quotes</string>
                <key>scope</key>
                <string>markup.quote</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base09}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Separator</string>
                <key>scope</key>
                <string>meta.separator</string>
                <key>settings</key>
                <dict>
                    <key>background</key>
                    <string>#${c.base02}</string>
                    <key>foreground</key>
                    <string>#${c.base05}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Inserted</string>
                <key>scope</key>
                <string>markup.inserted</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0B}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Deleted</string>
                <key>scope</key>
                <string>markup.deleted</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base08}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Changed</string>
                <key>scope</key>
                <string>markup.changed</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0E}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Colors</string>
                <key>scope</key>
                <string>constant.other.color</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0C}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Regular Expressions</string>
                <key>scope</key>
                <string>string.regexp</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0C}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Escape Characters</string>
                <key>scope</key>
                <string>constant.character.escape</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0C}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Embedded</string>
                <key>scope</key>
                <string>punctuation.section.embedded, variable.interpolation</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>#${c.base0E}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Illegal</string>
                <key>scope</key>
                <string>invalid.illegal</string>
                <key>settings</key>
                <dict>
                    <key>background</key>
                    <string>#${c.base08}</string>
                    <key>foreground</key>
                    <string>#${c.base07}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Broken</string>
                <key>scope</key>
                <string>invalid.broken</string>
                <key>settings</key>
                <dict>
                    <key>background</key>
                    <string>#${c.base09}</string>
                    <key>foreground</key>
                    <string>#${c.base00}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Deprecated</string>
                <key>scope</key>
                <string>invalid.deprecated</string>
                <key>settings</key>
                <dict>
                    <key>background</key>
                    <string>#${c.base0F}</string>
                    <key>foreground</key>
                    <string>#${c.base07}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Unimplemented</string>
                <key>scope</key>
                <string>invalid.unimplemented</string>
                <key>settings</key>
                <dict>
                    <key>background</key>
                    <string>#${c.base03}</string>
                    <key>foreground</key>
                    <string>#${c.base07}</string>
                </dict>
            </dict>
        </array>
        <key>uuid</key>
        <string>uuid</string>
    </dict>
</plist>
''
