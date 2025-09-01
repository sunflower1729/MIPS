# MIPS 5-Stage Pipeline CPU (Verilog)

본 프로젝트는 **MIPS 구조**를 기반으로 한 5단계 파이프라인 CPU를 Verilog로 설계한 개인 프로젝트입니다.  
파이프라이닝 기법을 적용하여 실행 시간을 최소화하고, 발생 가능한 다양한 Hazard를 해결하는 방법을 구현하였습니다.

---

## 📌 주요 특징

### ✅ 파이프라인 구조
- 5단계 파이프라인: IF → ID → EX → MEM → WB
- 파이프라이닝을 통해 명령어 처리 속도 향상

### ✅ Hazard 해결 기법
1. **구조적 해저드 (Structural Hazard)**  
   - Instruction Memory와 Data Memory를 분리하여 해결

2. **데이터 해저드 (Data Hazard)**  
   - **Forwarding (전방 전달)** 기법 적용  
   - R-format 연산 시 EX 단계에서 결과를 바로 전달하여 데이터 의존성 문제 해결  
   - Forwarding을 위한 새로운 제어 신호 설계

3. **제어 해저드 (Control Hazard)**  
   - 기본: **분기가 일어나지 않는다고 예측 후 실행**, 실제 분기 발생 시 flush 처리  
   - 최적화: **ID 단계에서 분기 여부 및 목적지 주소를 계산**하여 지연 최소화  
   - `IF.Flush`를 통해 잘못된 명령어 무효화

---

## 🖼️ 파이프라인 다이어그램 (Mermaid 예시)

```mermaid
flowchart LR
    IF["IF (Instruction Fetch)"] --> ID["ID (Instruction Decode)"]
    ID --> EX["EX (Execute)"]
    EX --> MEM["MEM (Memory Access)"]
    MEM --> WB["WB (Write Back)"]

flowchart TB
    subgraph Pipeline Stages
        EX1["EX (Instr N)"] --> MEM1["MEM (Instr N)"] --> WB1["WB (Instr N)"]
        ID2["ID (Instr N+1)"] --> EX2["EX (Instr N+1)"]
    end

    MEM1 -- Forwarding --> EX2
    WB1 -- Forwarding --> EX2

---

