//
//  ContentView.swift
//  SimpleBunny
//
//  Created by You on 2025/9/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // 漸層背景：天空藍 → 薄荷綠
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.sRGB, red: 0.80, green: 0.92, blue: 1.00, opacity: 1.0), // 天空藍
                    Color(.sRGB, red: 0.78, green: 0.96, blue: 0.90, opacity: 1.0)  // 薄荷綠
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer(minLength: 20)

                BunnyLineArt()
                    .frame(width: 280, height: 360)

                Text("我是小兔子")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.black.opacity(0.8))
                    .padding(.top, 8)

                Spacer(minLength: 24)
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Bunny built from circles, lines and rectangles only
struct BunnyLineArt: View {
    var body: some View {
        GeometryReader { g in
            let W = g.size.width
            let H = g.size.height
            let S = min(W, H)
            let line = max(2, S * 0.028)
            let stroke = StrokeStyle(lineWidth: line, lineCap: .round, lineJoin: .round)

            // Color palette
            let bodyFill = Color(.sRGB, red: 0.93, green: 0.93, blue: 0.95, opacity: 1.0)
            let bellyFill = Color(.sRGB, red: 0.97, green: 0.97, blue: 0.99, opacity: 1.0)
            let innerEarFill = Color(.sRGB, red: 1.0, green: 0.78, blue: 0.84, opacity: 1.0)
            let carrotFill = Color(.sRGB, red: 1.0, green: 0.60, blue: 0.20, opacity: 1.0)
            let leafFill = Color(.sRGB, red: 0.25, green: 0.70, blue: 0.40, opacity: 1.0)
            let groundStroke = Color.black.opacity(0.25)
            let outline = Color.black
            let detail = Color.black

            ZStack {
                // 地面一條線
                Path { p in
                    p.move(to: CGPoint(x: W * 0.08, y: H * 0.92))
                    p.addLine(to: CGPoint(x: W * 0.92, y: H * 0.92))
                }
                .stroke(groundStroke, style: stroke)

                // 手：加長、角度更水平、位置外移一點（仍在身體底下）
                RoundedRectangle(cornerRadius: S * 0.2)
                    .fill(bodyFill)
                    .frame(width: W * 0.34, height: H * 0.10)
                    .rotationEffect(.degrees(-20))
                    .position(x: W * 0.30, y: H * 0.60)
                    .overlay(
                        RoundedRectangle(cornerRadius: S * 0.2)
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.34, height: H * 0.10)
                            .rotationEffect(.degrees(-20))
                            .position(x: W * 0.30, y: H * 0.60)
                    )

                RoundedRectangle(cornerRadius: S * 0.2)
                    .fill(bodyFill)
                    .frame(width: W * 0.34, height: H * 0.10)
                    .rotationEffect(.degrees(20))
                    .position(x: W * 0.70, y: H * 0.60)
                    .overlay(
                        RoundedRectangle(cornerRadius: S * 0.2)
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.34, height: H * 0.10)
                            .rotationEffect(.degrees(20))
                            .position(x: W * 0.70, y: H * 0.60)
                    )

                // 身體（大圓） fill + outline
                Circle()
                    .fill(bodyFill)
                    .frame(width: W * 0.56, height: W * 0.56)
                    .position(x: W * 0.50, y: H * 0.62)
                    .overlay(
                        Circle()
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.56, height: W * 0.56)
                            .position(x: W * 0.50, y: H * 0.62)
                    )

                // 臉（中圓） fill + outline
                Circle()
                    .fill(bodyFill)
                    .frame(width: W * 0.46, height: W * 0.46)
                    .position(x: W * 0.50, y: H * 0.36)
                    .overlay(
                        Circle()
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.46, height: W * 0.46)
                            .position(x: W * 0.50, y: H * 0.36)
                    )

                // 左耳（長圓） fill + outline
                RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                    .fill(bodyFill)
                    .frame(width: W * 0.18, height: H * 0.46)
                    .rotationEffect(.degrees(-10))
                    .position(x: W * 0.34, y: H * 0.10)
                    .overlay(
                        RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.18, height: H * 0.46)
                            .rotationEffect(.degrees(-10))
                            .position(x: W * 0.34, y: H * 0.10)
                    )

                // 左耳內部
                RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                    .fill(innerEarFill)
                    .frame(width: W * 0.10, height: H * 0.34)
                    .rotationEffect(.degrees(-10))
                    .position(x: W * 0.34, y: H * 0.12)
                    .overlay(
                        RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                            .stroke(outline.opacity(0.45), lineWidth: line * 0.8)
                            .frame(width: W * 0.10, height: H * 0.34)
                            .rotationEffect(.degrees(-10))
                            .position(x: W * 0.34, y: H * 0.12)
                    )

                // 右耳（長圓） fill + outline
                RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                    .fill(bodyFill)
                    .frame(width: W * 0.18, height: H * 0.46)
                    .rotationEffect(.degrees(10))
                    .position(x: W * 0.66, y: H * 0.10)
                    .overlay(
                        RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.18, height: H * 0.46)
                            .rotationEffect(.degrees(10))
                            .position(x: W * 0.66, y: H * 0.10)
                    )

                // 右耳內部
                RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                    .fill(innerEarFill)
                    .frame(width: W * 0.10, height: H * 0.34)
                    .rotationEffect(.degrees(10))
                    .position(x: W * 0.66, y: H * 0.12)
                    .overlay(
                        RoundedRectangle(cornerRadius: S * 0.20, style: .continuous)
                            .stroke(outline.opacity(0.45), lineWidth: line * 0.8)
                            .frame(width: W * 0.10, height: H * 0.34)
                            .rotationEffect(.degrees(10))
                            .position(x: W * 0.66, y: H * 0.12)
                    )

                // 眼睛（小圓）
                Circle()
                    .fill(detail)
                    .frame(width: line * 0.9, height: line * 0.9)
                    .position(x: W * 0.44, y: H * 0.34)
                Circle()
                    .fill(detail)
                    .frame(width: line * 0.9, height: line * 0.9)
                    .position(x: W * 0.56, y: H * 0.34)

                // 鼻子 + 嘴
                Circle()
                    .fill(detail)
                    .frame(width: line * 0.9, height: line * 0.9)
                    .position(x: W * 0.50, y: H * 0.38)

                Path { p in
                    p.move(to: CGPoint(x: W * 0.50, y: H * 0.39))
                    p.addLine(to: CGPoint(x: W * 0.50, y: H * 0.415))
                    p.move(to: CGPoint(x: W * 0.50, y: H * 0.415))
                    p.addLine(to: CGPoint(x: W * 0.47, y: H * 0.425))
                    p.move(to: CGPoint(x: W * 0.50, y: H * 0.415))
                    p.addLine(to: CGPoint(x: W * 0.53, y: H * 0.425))
                }
                .stroke(detail, style: stroke)

                // 鬍鬚（左右三條）
                Path { p in
                    let y = H * 0.40
                    p.move(to: CGPoint(x: W * 0.36, y: y - H * 0.02))
                    p.addLine(to: CGPoint(x: W * 0.22, y: y - H * 0.03))
                    p.move(to: CGPoint(x: W * 0.36, y: y))
                    p.addLine(to: CGPoint(x: W * 0.22, y: y))
                    p.move(to: CGPoint(x: W * 0.36, y: y + H * 0.02))
                    p.addLine(to: CGPoint(x: W * 0.22, y: y + H * 0.03))
                }
                .stroke(detail, style: stroke)

                Path { p in
                    let y = H * 0.40
                    p.move(to: CGPoint(x: W * 0.64, y: y - H * 0.02))
                    p.addLine(to: CGPoint(x: W * 0.78, y: y - H * 0.03))
                    p.move(to: CGPoint(x: W * 0.64, y: y))
                    p.addLine(to: CGPoint(x: W * 0.78, y: y))
                    p.move(to: CGPoint(x: W * 0.64, y: y + H * 0.02))
                    p.addLine(to: CGPoint(x: W * 0.78, y: y + H * 0.03))
                }
                .stroke(detail, style: stroke)

                // 腳（小圓） fill + outline
                Circle()
                    .fill(bodyFill)
                    .frame(width: W * 0.22, height: W * 0.22)
                    .position(x: W * 0.40, y: H * 0.88)
                    .overlay(
                        Circle()
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.22, height: W * 0.22)
                            .position(x: W * 0.40, y: H * 0.88)
                    )
                Circle()
                    .fill(bodyFill)
                    .frame(width: W * 0.22, height: W * 0.22)
                    .position(x: W * 0.60, y: H * 0.88)
                    .overlay(
                        Circle()
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.22, height: W * 0.22)
                            .position(x: W * 0.60, y: H * 0.88)
                    )

                // 肚皮（橢圓） fill + soft ring
                Circle()
                    .fill(bellyFill)
                    .scaleEffect(x: 0.75, y: 1.05, anchor: .center)
                    .frame(width: W * 0.46, height: W * 0.46)
                    .position(x: W * 0.50, y: H * 0.66)
                    .overlay(
                        Circle()
                            .stroke(outline.opacity(0.6), lineWidth: line * 0.8)
                            .scaleEffect(x: 0.75, y: 1.05, anchor: .center)
                            .frame(width: W * 0.46, height: W * 0.46)
                            .position(x: W * 0.50, y: H * 0.66)
                    )

                // 胡蘿蔔（長方形） fill + outline
                RoundedRectangle(cornerRadius: line)
                    .fill(carrotFill)
                    .frame(width: W * 0.10, height: H * 0.24)
                    .rotationEffect(.degrees(-35))
                    .position(x: W * 0.24, y: H * 0.70)
                    .overlay(
                        RoundedRectangle(cornerRadius: line)
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.10, height: H * 0.24)
                            .rotationEffect(.degrees(-35))
                            .position(x: W * 0.24, y: H * 0.70)
                    )

                // 胡蘿蔔葉（用三角形表示） fill + outline
                Triangle()
                    .fill(leafFill)
                    .frame(width: W * 0.14, height: H * 0.12)
                    .rotationEffect(.degrees(-35))
                    .position(x: W * 0.18, y: H * 0.60)
                    .overlay(
                        Triangle()
                            .stroke(outline, lineWidth: line)
                            .frame(width: W * 0.14, height: H * 0.12)
                            .rotationEffect(.degrees(-35))
                            .position(x: W * 0.18, y: H * 0.60)
                    )
            }
        }
    }
}

// 簡單三角形
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

#Preview {
    ContentView()
}
