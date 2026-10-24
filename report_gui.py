#!/usr/bin/env python3
"""
Qt GUI for build_report.py  (keep both files in the same folder).

Setup:  pip install PySide6 python-docx pygments
Run:    python report_gui.py
"""
import os
import sys
from pathlib import Path

from PySide6.QtCore import QThread, Signal, Qt
from PySide6.QtGui import QFont, QTextCursor
from PySide6.QtWidgets import (
    QApplication, QCheckBox, QFileDialog, QHBoxLayout, QLabel, QLineEdit,
    QMessageBox, QProgressBar, QPushButton, QRadioButton, QButtonGroup,
    QPlainTextEdit, QVBoxLayout, QWidget,
)

import build_report

STYLE = """
QWidget { font-size: 13px; }
QLabel#heading { font-weight: bold; font-size: 14px; }
QLineEdit, QPlainTextEdit {
    border: 1.5px solid #555; border-radius: 8px; padding: 6px;
}
QPushButton {
    border: 1.5px solid #555; border-radius: 8px; padding: 7px 16px; font-weight: bold;
}
QPushButton:hover { background: #e8e8e8; }
QPushButton:disabled { color: #999; border-color: #bbb; }
QPushButton#generate { font-size: 14px; padding: 10px 40px; }
QProgressBar {
    border: 1.5px solid #555; border-radius: 8px; text-align: center; height: 22px;
}
QProgressBar::chunk { background: #4a90d9; border-radius: 6px; }
"""


class Worker(QThread):
    log = Signal(str)
    progress = Signal(int)
    finished_ok = Signal(str)
    failed = Signal(str)

    def __init__(self, folder, engine, fix_plots, out_path):
        super().__init__()
        self.folder, self.engine = folder, engine
        self.fix_plots, self.out_path = fix_plots, out_path

    def run(self):
        try:
            build_report.build(
                Path(self.folder).resolve(), str(self.out_path), self.engine,
                timeout=300, fix_plots=self.fix_plots,
                log=self.log.emit, progress=self.progress.emit,
            )
            self.finished_ok.emit(str(self.out_path))
        except Exception as e:  # show any error in the console log
            self.failed.emit(f"{type(e).__name__}: {e}")


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("MATLAB Assignments → Word")
        self.resize(760, 600)
        self.worker = None

        root = QVBoxLayout(self)
        root.setContentsMargins(24, 20, 24, 20)
        root.setSpacing(10)

        # --- folder chooser
        h = QLabel("Choose Folder"); h.setObjectName("heading")
        root.addWidget(h)
        row = QHBoxLayout()
        self.path_edit = QLineEdit()
        self.path_edit.setPlaceholderText(r"Folder containing ASSIGNMENT 1, ASSIGNMENT 2 ...")
        browse = QPushButton("Browse")
        browse.clicked.connect(self.browse)
        row.addWidget(self.path_edit, 1)
        row.addWidget(browse)
        root.addLayout(row)

        # --- run mode
        root.addSpacing(6)
        self.r_matlab = QRadioButton("Run with MATLAB")
        self.r_octave = QRadioButton("Run with Octave")
        self.r_none = QRadioButton("Don't run (use saved output files)")
        self.r_matlab.setChecked(True)
        grp = QButtonGroup(self)
        for r in (self.r_matlab, self.r_octave, self.r_none):
            grp.addButton(r)
            root.addWidget(r)
        self.fix_plots = QCheckBox("Make figures readable (white background, dark text)")
        self.fix_plots.setChecked(True)
        root.addWidget(self.fix_plots)

        # --- generate
        root.addSpacing(6)
        self.btn = QPushButton("GENERATE")
        self.btn.setObjectName("generate")
        self.btn.clicked.connect(self.generate)
        center = QHBoxLayout()
        center.addStretch(); center.addWidget(self.btn); center.addStretch()
        root.addLayout(center)

        # --- progress + log
        self.prog_label = QLabel("Progress: 0%"); self.prog_label.setObjectName("heading")
        root.addWidget(self.prog_label)
        self.bar = QProgressBar(); self.bar.setRange(0, 100)
        self.bar.setTextVisible(False)
        root.addWidget(self.bar)

        l = QLabel("Console Log:"); l.setObjectName("heading")
        root.addWidget(l)
        self.console = QPlainTextEdit(); self.console.setReadOnly(True)
        mono = QFont("Consolas"); mono.setStyleHint(QFont.Monospace); mono.setPointSize(10)
        self.console.setFont(mono)
        root.addWidget(self.console, 1)

    # ------------------------------------------------------------ actions
    def browse(self):
        d = QFileDialog.getExistingDirectory(self, "Select folder", self.path_edit.text() or str(Path.home()))
        if d:
            self.path_edit.setText(d)

    def log(self, text):
        self.console.appendPlainText(text)
        self.console.moveCursor(QTextCursor.End)

    def set_progress(self, pct):
        self.bar.setValue(pct)
        self.prog_label.setText(f"Progress: {pct}%")

    def generate(self):
        folder = self.path_edit.text().strip().strip('"')
        if not folder or not Path(folder).is_dir():
            QMessageBox.warning(self, "No folder", "Please choose a valid folder first.")
            return
        engine = "matlab" if self.r_matlab.isChecked() else "octave" if self.r_octave.isChecked() else "none"
        out_path = Path(folder) / "MATLAB_Assignments.docx"

        self.console.clear()
        self.set_progress(0)
        self.btn.setEnabled(False)
        self.log(f"Folder: {folder}\nMode: {engine}\n")

        self.worker = Worker(folder, engine, self.fix_plots.isChecked(), out_path)
        self.worker.log.connect(self.log)
        self.worker.progress.connect(self.set_progress)
        self.worker.finished_ok.connect(self.done)
        self.worker.failed.connect(self.fail)
        self.worker.start()

    def done(self, path):
        self.btn.setEnabled(True)
        self.log("\nDone ✔")
        if QMessageBox.question(self, "Finished", f"Saved:\n{path}\n\nOpen it now?") == QMessageBox.Yes:
            if sys.platform == "win32":
                os.startfile(path)
            elif sys.platform == "darwin":
                os.system(f'open "{path}"')
            else:
                os.system(f'xdg-open "{path}"')

    def fail(self, msg):
        self.btn.setEnabled(True)
        self.log(f"\nERROR: {msg}")


def main():
    app = QApplication(sys.argv)
    app.setStyleSheet(STYLE)
    w = Window()
    w.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()