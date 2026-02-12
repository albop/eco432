#import "@preview/cetz:0.4.2" as cetz

// Shared helpers for simple AS/AD-style diagrams (y on x-axis, π on y-axis)

#let _asad_canvas(body, length: 0.55cm) = {
	cetz.canvas(length: length, {
		import cetz.draw as draw

		// Sensible defaults
		draw.set-style(
			stroke: (thickness: 0.9pt),
			content: (padding: 0.04),
			mark: (end: "stealth", length: 0.18cm, width: 0.12cm),
		)

		body(draw)
	})
}

#let _stroke(thickness: 0.9pt, paint: black, dash: none) = (
	paint: paint,
	thickness: thickness,
	dash: dash,
)

#let _axes(draw, xmax, ymax, xlabel: [$y$], ylabel: [$pi$]) = {
	// Axes (with arrow tips)
	draw.line((0, 0), (xmax, 0), stroke: _stroke(thickness: 1.0pt), mark: (end: "stealth"))
	draw.line((0, 0), (0, ymax), stroke: _stroke(thickness: 1.0pt), mark: (end: "stealth"))

	// Axis labels
	draw.content((xmax, 0), xlabel, anchor: "west", padding: 0.12)
	draw.content((0, ymax), ylabel, anchor: "south", padding: 0.12)
}

#let _curve(
	draw,
	a,
	b,
	label,
	label_pos: 70%,
	label_anchor: "south-east",
	label_padding: 0.08,
	label_offset: (0, 0),
	stroke: _stroke(),
) = {
	draw.line(a, b, stroke: stroke, mark: (end: none))
	let t = label_pos / 100%
	let p = (a.at(0) + t * (b.at(0) - a.at(0)), a.at(1) + t * (b.at(1) - a.at(1)))
	let dx = label_offset.at(0)
	let dy = label_offset.at(1)
	let p2 = (p.at(0) + dx, p.at(1) + dy)
	draw.content(p2, label, anchor: label_anchor, padding: label_padding)
}

#let _eq(draw, name, p, xlab: none, ylab: none, guide_stroke: _stroke(thickness: 0.7pt, paint: gray, dash: "dashed")) = {
	// Point
	draw.circle(p, radius: 2pt, fill: black, stroke: none, name: name)
	let px = p.at(0)
	let py = p.at(1)

	// Guides
	if guide_stroke != none {
		draw.line((px, 0), p, stroke: guide_stroke, mark: (end: none))
		draw.line((0, py), p, stroke: guide_stroke, mark: (end: none))
	}

	// Labels on axes
	if xlab != none {
		draw.content((px, 0), xlab, anchor: "north", padding: 0.08)
	}
	if ylab != none {
		draw.content((0, py), ylab, anchor: "east", padding: 0.08)
	}
}

#let _marker(draw, p, radius: 2pt, fill: black) = {
	draw.circle(p, radius: radius, fill: fill, stroke: none)
}

#let _arrow(draw, a, b, label: none, label_pos: 50%, label_anchor: "south", stroke: _stroke(thickness: 0.8pt, paint: gray)) = {
	draw.line(a, b, stroke: stroke, mark: (end: "stealth"))
	if label != none {
		draw.content(
			(a, label_pos, b),
			box(fill: white, inset: (x: 1.4pt, y: 0.8pt))[#label],
			anchor: label_anchor,
			padding: 0.06,
		)
	}
}

#let _arc_arrow(
	draw,
	center,
	radius,
	theta_start,
	theta_end,
	segments: 10,
	stroke: _stroke(thickness: 0.8pt, paint: gray),
) = {
	let cx = center.at(0)
	let cy = center.at(1)
	for i in range(segments) {
		let t0 = i / segments
		let t1 = (i + 1) / segments
		let th0 = theta_start + t0 * (theta_end - theta_start)
		let th1 = theta_start + t1 * (theta_end - theta_start)
		let p0 = (cx + radius * calc.cos(th0), cy + radius * calc.sin(th0))
		let p1 = (cx + radius * calc.cos(th1), cy + radius * calc.sin(th1))
		draw.line(p0, p1, stroke: stroke, mark: (end: if i == segments - 1 { "stealth" } else { none }))
	}
}

// Geometry helpers
#let _line_intersection(a1, a2, b1, b2) = {
	let x1 = a1.at(0)
	let y1 = a1.at(1)
	let x2 = a2.at(0)
	let y2 = a2.at(1)
	let x3 = b1.at(0)
	let y3 = b1.at(1)
	let x4 = b2.at(0)
	let y4 = b2.at(1)

	let den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
	// Assumes non-parallel lines in our diagrams
	let num_x = (x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)
	let num_y = (x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)
	(num_x / den, num_y / den)
}

#let _point_at_y(a, b, y) = {
	let x1 = a.at(0)
	let y1 = a.at(1)
	let x2 = b.at(0)
	let y2 = b.at(1)
	let t = (y - y1) / (y2 - y1)
	(x1 + t * (x2 - x1), y)
}

#let _point_at_t(a, b, t) = {
	let x1 = a.at(0)
	let y1 = a.at(1)
	let x2 = b.at(0)
	let y2 = b.at(1)
	(x1 + t * (x2 - x1), y1 + t * (y2 - y1))
}

#let _label_point_off_line(a, b, t, dist: 0.22) = {
	let p = _point_at_t(a, b, t)
	let dx = b.at(0) - a.at(0)
	let dy = b.at(1) - a.at(1)
	// Normal vector (-dy, dx), normalized. Special-case vertical lines.
	if dx == 0 {
		(p.at(0) + dist, p.at(1))
	} else {
		let nx = -dy
		let ny = dx
		let nlen = calc.sqrt(nx * nx + ny * ny)
		(p.at(0) + dist * nx / nlen, p.at(1) + dist * ny / nlen)
	}
}


// Simple time-series subplot (used for y_t and pi_t)
#let _timeseries_subplot(
	draw,
	origin,
	width,
	height,
	values,
	ylabel,
	xlabel: none,
	t_end: none,
	zero_line: false,
	margins: (left: 0.9, right: 0.2, bottom: 0.55, top: 0.25),
	stroke: _stroke(),
) = {
	let ox = origin.at(0)
	let oy = origin.at(1)
	let left = margins.left
	let right = margins.right
	let bottom = margins.bottom
	let top = margins.top
	let w = width - left - right
	let h = height - bottom - top

	let tmax_data = values.len() - 1
	let tmax = if t_end == none { tmax_data } else { t_end }
	let vmin = calc.min(..values)
	let vmax = calc.max(..values)
	let span = if vmax - vmin == 0 { 1 } else { vmax - vmin }
	let pad = 0.1 * span
	let v0 = vmin - pad
	let v1 = vmax + pad
	let vspan = v1 - v0

	// Axes
	draw.line((ox + left, oy + bottom), (ox + left + w, oy + bottom), stroke: _stroke(thickness: 0.9pt), mark: (end: "stealth"))
	draw.line((ox + left, oy + bottom), (ox + left, oy + bottom + h), stroke: _stroke(thickness: 0.9pt), mark: (end: "stealth"))

	// Axis labels
	draw.content((ox + left, oy + bottom + h), ylabel, anchor: "south-east", padding: 0.06)
	if xlabel != none {
		draw.content((ox + left + w, oy + bottom), xlabel, anchor: "north-west", padding: 0.06)
	}

	// x ticks (t = 0..tmax)
	for t in range(tmax + 1) {
		let x = ox + left + (t / tmax) * w
		draw.line((x, oy + bottom), (x, oy + bottom - 0.10), stroke: _stroke(thickness: 0.7pt), mark: (end: none))
		if xlabel != none {
			draw.content((x, oy + bottom), [$#t$], anchor: "north", padding: 0.04)
		}
	}

	// Optional dashed y=0 reference line
	if zero_line {
		if v0 <= 0 and 0 <= v1 {
			let y0_line = oy + bottom + ((0 - v0) / vspan) * h
			draw.line(
				(ox + left, y0_line),
				(ox + left + w, y0_line),
				stroke: _stroke(thickness: 0.7pt, paint: gray, dash: "dashed"),
				mark: (end: none),
			)
		}
	}

	// Series polyline + markers
	let prev = none
	for i in range(values.len()) {
		let t = i
		let x = ox + left + (t / tmax) * w
		let y = oy + bottom + ((values.at(i) - v0) / vspan) * h
		let p = (x, y)
		if prev != none {
			draw.line(prev, p, stroke: stroke, mark: (end: none))
		}
		draw.circle(p, radius: 1.7pt, fill: black, stroke: none)
		prev = p
	}
}


// --- Public graphs ---------------------------------------------------------

// Demand shock: AD shifts, new short-run equilibrium
#let demand_shock(length: 0.55cm) = _asad_canvas(length: length, draw => {
	let xmax = 6
	let ymax = 5

	_axes(draw, xmax, ymax, xlabel: [$y$], ylabel: [$pi$])

	// Demand (baseline) and two policy responses
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let adY_a = (2.1, 4.6) // stimulate to stabilize output (DA')
	let adY_b = (6.1, 1.2)

	// Curves
	let as_a = (1.2, 1.0)
	let as_b = (5.2, 4.6)
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let ad1_a = (2.0, 4.6)
	let ad1_b = (6.0, 1.2)

	_curve(draw, as_a, as_b, [OA], label_pos: 78%, label_anchor: "south-east")
	_curve(draw, ad0_a, ad0_b, [DA], label_pos: 82%, label_anchor: "south-west")
	_curve(draw, ad1_a, ad1_b, [DA$'$], label_pos: 82%, label_anchor: "south-west")

	// Equilibria
	let e0 = _line_intersection(as_a, as_b, ad0_a, ad0_b)
	let e1 = _line_intersection(as_a, as_b, ad1_a, ad1_b)
	_eq(draw, "e0", e0, xlab: [$y$], ylab: [$pi$])
	_eq(draw, "e1", e1, xlab: [$y'$], ylab: [$pi'$])

	// Demand shift arrow (horizontal: from DA to DA', near the labels)
	// Use a float parameter (not a ratio like 82%) to avoid type issues.
	let label_t = 0.82
	let y_arrow = ad0_a.at(1) + label_t * (ad0_b.at(1) - ad0_a.at(1))
	let shift_from = _point_at_y(ad0_a, ad0_b, y_arrow)
	let shift_to = _point_at_y(ad1_a, ad1_b, y_arrow)
	_arrow(draw, shift_from, shift_to)
})


// Persistent demand shock + gradual price adjustment: OA steepens over time
#let demand_shock_adjustment(length: 0.55cm) = _asad_canvas(length: length, draw => {
	let xmax = 6
	let ymax = 5

	_axes(draw, xmax, ymax, xlabel: [$y$], ylabel: [$pi$])

	// Demand: baseline and shocked
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let ad1_a = (2.0, 4.6)
	let ad1_b = (6.0, 1.2)
	_curve(draw, ad0_a, ad0_b, [DA], label_pos: 82%, label_anchor: "south-west")
	_curve(draw, ad1_a, ad1_b, [DA$'$], label_pos: 82%, label_anchor: "south-west")

	// Supply: a finite set of curves OA_n, rotated around the initial equilibrium
	let as0_a = (1.4, 1.0)
	let as0_b = (5.4, 4.2)
	let e0 = _line_intersection(as0_a, as0_b, ad0_a, ad0_b)

	let x0 = e0.at(0)
	let y0 = e0.at(1)
	let m0 = (as0_b.at(1) - as0_a.at(1)) / (as0_b.at(0) - as0_a.at(0))

	let supply_count = 4
	let y_low = 1.0
	let y_high = 4.8
	let theta0 = calc.atan(m0)
	let thetaV = 90deg

	let asN_a = none
	let asN_b = none
	for n in range(supply_count) {
		let a = if n == supply_count - 1 {
			(x0, y_low)
		} else {
			let t = n / (supply_count - 1)
			let theta = theta0 + t * (thetaV - theta0)
			let m = calc.tan(theta)
			(x0 + (y_low - y0) / m, y_low)
		}
		let b = if n == supply_count - 1 {
			(x0, y_high)
		} else {
			let t = n / (supply_count - 1)
			let theta = theta0 + t * (thetaV - theta0)
			let m = calc.tan(theta)
			(x0 + (y_high - y0) / m, y_high)
		}
		let supply_stroke = if n == 0 or n == supply_count - 1 {
			_stroke()
		} else {
			_stroke(thickness: 0.85pt, paint: gray)
		}
		draw.line(a, b, stroke: supply_stroke, mark: (end: none))
		// Labels: anchor at each curve's top point (text to the left), nudged upward
		let b_label = (b.at(0), b.at(1) + 0.08)
		draw.content(b_label, [$"OA"_#(n+1)$], anchor: "east", padding: 0.08)

		if n != 0 and n != supply_count - 1 {
			// Marker at OA_n ∩ DA'
			let p = _line_intersection(a, b, ad1_a, ad1_b)
			_marker(draw, p, radius: 1.7pt, fill: gray)
		}
		asN_a = a
		asN_b = b
	}

	// Sequence of equilibria (stylised)
	let e1 = _line_intersection(as0_a, as0_b, ad1_a, ad1_b) // impact (OA0 with DA')
	let e2 = _line_intersection(asN_a, asN_b, ad1_a, ad1_b) // prices adjust (OA_{N} with DA')
	let e3 = _line_intersection(asN_a, asN_b, ad0_a, ad0_b) // shock ends (OA_{N} with DA)

	_eq(draw, "e0", e0, xlab: [$overline(y)$], ylab: [$overline(pi)$])
	_eq(draw, "e1", e1, xlab: [$y_0$], ylab: [$pi_1$])
	_eq(draw, "e2", e2, ylab: [$overline(pi)'$])
	_eq(draw, "e3", e3)

	// Demand shift arrow (horizontal: DA -> DA', same placement as in demand_shock)
	let label_t = 0.82
	let y_arrow = ad0_a.at(1) + label_t * (ad0_b.at(1) - ad0_a.at(1))
	let shift_from = _point_at_y(ad0_a, ad0_b, y_arrow)
	let shift_to = _point_at_y(ad1_a, ad1_b, y_arrow)
	_arrow(draw, shift_from, shift_to)

	// Curved arrows for supply rotation (OA0 -> OA_{N}) around the initial equilibrium
	_arc_arrow(draw, e0, 1.0, theta0, thetaV, segments: 12)
})


// Demand shock + partial reversal: after two periods, demand shifts back left by 1/3, then again by 1/3.
#let demand_shock_adjustment_partial_reversal(length: 0.55cm) = _asad_canvas(length: length, draw => {
	let xmax = 6
	let ymax = 5

	_axes(draw, xmax, ymax, xlabel: [$y$], ylabel: [$pi$])

	// Demand: baseline, full shock, then two partial reversals
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let ad1_a = (2.0, 4.6)
	let ad1_b = (6.0, 1.2)
	let dshock = ad1_a.at(0) - ad0_a.at(0)
	let step = dshock / 3
	let ad2_a = (ad1_a.at(0) - step, ad1_a.at(1))
	let ad2_b = (ad1_b.at(0) - step, ad1_b.at(1))
	let ad3_a = (ad1_a.at(0) - 2 * step, ad1_a.at(1))
	let ad3_b = (ad1_b.at(0) - 2 * step, ad1_b.at(1))

	// Demand labels at the bottom endpoint (same style as stabilization)
	_curve(draw, ad0_a, ad0_b, [DA], label_pos: 100%, label_anchor: "north-west")
	_curve(draw, ad1_a, ad1_b, [DA$'$], label_pos: 100%, label_anchor: "north-west")
	_curve(draw, ad2_a, ad2_b, [], stroke: _stroke(thickness: 0.85pt, paint: gray), label_padding: 0pt)
	_curve(draw, ad3_a, ad3_b, [], stroke: _stroke(thickness: 0.85pt, paint: gray), label_padding: 0pt)

	// Supply: OA_n rotates around initial equilibrium (same construction as demand_shock_adjustment)
	let as0_a = (1.4, 1.0)
	let as0_b = (5.4, 4.2)
	let e0 = _line_intersection(as0_a, as0_b, ad0_a, ad0_b)

	let x0 = e0.at(0)
	let y0 = e0.at(1)
	let m0 = (as0_b.at(1) - as0_a.at(1)) / (as0_b.at(0) - as0_a.at(0))
	let theta0 = calc.atan(m0)
	let thetaV = 90deg

	let supply_count = 4
	let y_low = 1.0
	let y_high = 4.8
	let as2_a = none
	let as2_b = none
	let as3_a = none
	let as3_b = none
	let asN_a = none
	let asN_b = none
	for n in range(supply_count) {
		let a = if n == supply_count - 1 {
			(x0, y_low)
		} else {
			let t = n / (supply_count - 1)
			let theta = theta0 + t * (thetaV - theta0)
			let m = calc.tan(theta)
			(x0 + (y_low - y0) / m, y_low)
		}
		let b = if n == supply_count - 1 {
			(x0, y_high)
		} else {
			let t = n / (supply_count - 1)
			let theta = theta0 + t * (thetaV - theta0)
			let m = calc.tan(theta)
			(x0 + (y_high - y0) / m, y_high)
		}
		let supply_stroke = if n == 0 or n == supply_count - 1 {
			_stroke()
		} else {
			_stroke(thickness: 0.85pt, paint: gray)
		}
		draw.line(a, b, stroke: supply_stroke, mark: (end: none))
		let b_label = (b.at(0), b.at(1) + 0.08)
		draw.content(b_label, [$"OA"_#(n+1)$], anchor: "east", padding: 0.08)

		// Capture OA2 (the curve labeled OA2)
		if n == 1 {
			as2_a = a
			as2_b = b
		}
		// Capture OA3 (the curve labeled OA3)
		if n == 2 {
			as3_a = a
			as3_b = b
		}
		asN_a = a
		asN_b = b
	}

	// Key equilibrium points (stylised)
	let e1 = _line_intersection(as0_a, as0_b, ad1_a, ad1_b) // impact
	let e2 = _line_intersection(as2_a, as2_b, ad1_a, ad1_b) // after two periods (OA_2 with DA')
	let e2b = _line_intersection(as3_a, as3_b, ad1_a, ad1_b) // OA_3 with DA'
	let e3 = _line_intersection(asN_a, asN_b, ad2_a, ad2_b) // demand reverts by 1/3
	let e4 = _line_intersection(asN_a, asN_b, ad3_a, ad3_b) // demand reverts by another 1/3

	_eq(draw, "e0", e0, xlab: [$overline(y)$], ylab: [$overline(pi)$], guide_stroke: none)
	_eq(draw, "e1", e1, xlab: [$y_0$], ylab: [$pi_0$], guide_stroke: none)
	_marker(draw, e2, radius: 1.7pt, fill: gray)
	_marker(draw, e2b, radius: 1.7pt, fill: gray)
	_marker(draw, e3, radius: 1.7pt, fill: gray)
	_marker(draw, e4, radius: 1.7pt, fill: gray)

	// Demand shift arrows (all horizontal, same placement logic as other demand-shock graphs)
	let label_t_left = 0.82
	let label_t_right = 0.90
	let y_arrow_left = ad0_a.at(1) + label_t_left * (ad0_b.at(1) - ad0_a.at(1))
	let y_arrow_right = ad0_a.at(1) + label_t_right * (ad0_b.at(1) - ad0_a.at(1))
	// Rightward shock arrow lower for clarity
	_arrow(draw, _point_at_y(ad0_a, ad0_b, y_arrow_right), _point_at_y(ad1_a, ad1_b, y_arrow_right))
	// Leftward reversal arrows higher
	_arrow(draw, _point_at_y(ad1_a, ad1_b, y_arrow_left), _point_at_y(ad2_a, ad2_b, y_arrow_left))
	_arrow(draw, _point_at_y(ad2_a, ad2_b, y_arrow_left), _point_at_y(ad3_a, ad3_b, y_arrow_left))
	// Final reversal back to DA (third left arrow)
	_arrow(draw, _point_at_y(ad3_a, ad3_b, y_arrow_left), _point_at_y(ad0_a, ad0_b, y_arrow_left))

	// Curved arrow for supply rotation
	_arc_arrow(draw, e0, 1.0, theta0, thetaV, segments: 12)
})


// Time series for the *transitory* demand shock with partial reversal:
// e0 -> e1 -> e2 -> e3 -> e4 -> e0 (last equals initial).
#let demand_shock_adjustment_partial_reversal_timeseries(length: 0.55cm) = _asad_canvas(length: length, draw => {
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let ad1_a = (2.0, 4.6)
	let ad1_b = (6.0, 1.2)

	let y_ref_tmp = 3.0
	let theta = _point_at_y(ad1_a, ad1_b, y_ref_tmp).at(0) - _point_at_y(ad0_a, ad0_b, y_ref_tmp).at(0)
	let step = theta / 3
	let ad2_a = (ad1_a.at(0) - step, ad1_a.at(1))
	let ad2_b = (ad1_b.at(0) - step, ad1_b.at(1))
	let ad3_a = (ad1_a.at(0) - 2 * step, ad1_a.at(1))
	let ad3_b = (ad1_b.at(0) - 2 * step, ad1_b.at(1))

	let as0_a = (1.4, 1.0)
	let as0_b = (5.4, 4.2)
	let e0 = _line_intersection(as0_a, as0_b, ad0_a, ad0_b)
	let x0 = e0.at(0)
	let y0 = e0.at(1)
	let m0 = (as0_b.at(1) - as0_a.at(1)) / (as0_b.at(0) - as0_a.at(0))
	let theta0 = calc.atan(m0)
	let thetaV = 90deg

	let supply_count = 4
	let y_low = 1.0
	let y_high = 4.8
	let as2_a = none
	let as2_b = none
	let as3_a = none
	let as3_b = none
	for n in range(supply_count) {
		let t = n / (supply_count - 1)
		let a = if n == supply_count - 1 {
			(x0, y_low)
		} else {
			let th = theta0 + t * (thetaV - theta0)
			let m = calc.tan(th)
			(x0 + (y_low - y0) / m, y_low)
		}
		let b = if n == supply_count - 1 {
			(x0, y_high)
		} else {
			let th = theta0 + t * (thetaV - theta0)
			let m = calc.tan(th)
			(x0 + (y_high - y0) / m, y_high)
		}
		if n == 1 {
			as2_a = a
			as2_b = b
		}
		if n == 2 {
			as3_a = a
			as3_b = b
		}
	}
	let asN_a = (x0, y_low)
	let asN_b = (x0, y_high)

	let e1 = _line_intersection(as0_a, as0_b, ad1_a, ad1_b)
	let e2 = _line_intersection(as2_a, as2_b, ad1_a, ad1_b)
	let e2b = _line_intersection(as3_a, as3_b, ad1_a, ad1_b)
	let e3 = _line_intersection(asN_a, asN_b, ad2_a, ad2_b)
	let e4 = _line_intersection(asN_a, asN_b, ad3_a, ad3_b)
	let e5 = _line_intersection(asN_a, asN_b, ad0_a, ad0_b)

	// Plot deviations from initial point so the dashed y=0 line is meaningful.
	let y_base = e0.at(0)
	let pi_base = e0.at(1)
	let ys = (
		e0.at(0) - y_base,
		e1.at(0) - y_base,
		e2.at(0) - y_base,
		e2b.at(0) - y_base,
		e3.at(0) - y_base,
		e4.at(0) - y_base,
		e5.at(0) - y_base,
	)
	let pis = (
		e0.at(1) - pi_base,
		e1.at(1) - pi_base,
		e2.at(1) - pi_base,
		e2b.at(1) - pi_base,
		e3.at(1) - pi_base,
		e4.at(1) - pi_base,
		e5.at(1) - pi_base,
	)
	let thetas = (0, theta, theta, theta, theta - step, theta - 2 * step, 0)

	let width = 6.0
	let height = 5.0
	let gap = 0.20
	let h_each = (height - 2 * gap) / 3
	let margins = (left: 0.80, right: 0.15, bottom: 0.32, top: 0.16)

	_timeseries_subplot(draw, (0, 2 * (h_each + gap)), width, h_each, ys, [$y$], xlabel: none, t_end: 8, zero_line: true, margins: margins)
	_timeseries_subplot(draw, (0, h_each + gap), width, h_each, pis, [$pi$], xlabel: none, t_end: 8, zero_line: true, margins: margins)
	_timeseries_subplot(draw, (0, 0), width, h_each, thetas, [$θ$], xlabel: [$t$], t_end: 8, zero_line: true, margins: margins)
})


// Time series for demand shock adjustment: stacked subplots for y_t and pi_t
#let demand_shock_adjustment_timeseries(length: 0.55cm) = _asad_canvas(length: length, draw => {
	// Recompute the same stylised sequence as demand_shock_adjustment
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let ad1_a = (2.0, 4.6)
	let ad1_b = (6.0, 1.2)
	let as0_a = (1.4, 1.0)
	let as0_b = (5.4, 4.2)

	let e0 = _line_intersection(as0_a, as0_b, ad0_a, ad0_b)
	let x0 = e0.at(0)
	let y0 = e0.at(1)
	let y_low = 1.0
	let y_high = 4.8
	let asN_a = (x0, y_low)
	let asN_b = (x0, y_high)

	let e1 = _line_intersection(as0_a, as0_b, ad1_a, ad1_b)
	let e2 = _line_intersection(asN_a, asN_b, ad1_a, ad1_b)
	let e3 = _line_intersection(asN_a, asN_b, ad0_a, ad0_b)

	// Demand-shock size (horizontal distance between DA' and DA at a fixed pi)
	let y_ref = e0.at(1)
	let theta = _point_at_y(ad1_a, ad1_b, y_ref).at(0) - _point_at_y(ad0_a, ad0_b, y_ref).at(0)

	let ys = (e0.at(0), e1.at(0), e2.at(0), e3.at(0))
	let pis = (e0.at(1), e1.at(1), e2.at(1), e3.at(1))
	let thetas = (0, theta, theta, 0)
	let y_base = ys.at(0)
	let pi_base = pis.at(0)
	let ys = (ys.at(0) - y_base, ys.at(1) - y_base, ys.at(2) - y_base, ys.at(3) - y_base)
	let pis = (pis.at(0) - pi_base, pis.at(1) - pi_base, pis.at(2) - pi_base, pis.at(3) - pi_base)

	// Layout: two subplots stacked
	let width = 6.0
	let height = 5.0
	let gap = 0.20
	let h_each = (height - 2 * gap) / 3
	let margins = (left: 0.80, right: 0.15, bottom: 0.32, top: 0.16)

	_timeseries_subplot(draw, (0, 2 * (h_each + gap)), width, h_each, ys, [$y$], xlabel: none, t_end: 8, zero_line: true, margins: margins)
	_timeseries_subplot(draw, (0, h_each + gap), width, h_each, pis, [$pi$], xlabel: none, t_end: 8, zero_line: true, margins: margins)
	_timeseries_subplot(draw, (0, 0), width, h_each, thetas, [$θ$], xlabel: [$t$], t_end: 8, zero_line: true, margins: margins)
})


// Time series for *persistent* demand shock adjustment (demand stays at DA'):
// e0 -> e1 -> e2 -> e2 (new steady state).
#let demand_shock_adjustment_persistent_timeseries(length: 0.55cm) = _asad_canvas(length: length, draw => {
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let ad1_a = (2.0, 4.6)
	let ad1_b = (6.0, 1.2)
	let as0_a = (1.4, 1.0)
	let as0_b = (5.4, 4.2)

	let e0 = _line_intersection(as0_a, as0_b, ad0_a, ad0_b)
	let x0 = e0.at(0)
	let y0 = e0.at(1)
	let y_low = 1.0
	let y_high = 4.8
	let m0 = (as0_b.at(1) - as0_a.at(1)) / (as0_b.at(0) - as0_a.at(0))
	let theta0 = calc.atan(m0)
	let thetaV = 90deg

	// Match demand_shock_adjustment: OA2 and OA3 are intermediate rotations, OA4 is vertical.
	let supply_count = 4
	let as2_a = {
		let t = 1 / (supply_count - 1)
		let theta = theta0 + t * (thetaV - theta0)
		let m = calc.tan(theta)
		(x0 + (y_low - y0) / m, y_low)
	}
	let as2_b = {
		let t = 1 / (supply_count - 1)
		let theta = theta0 + t * (thetaV - theta0)
		let m = calc.tan(theta)
		(x0 + (y_high - y0) / m, y_high)
	}
	let as3_a = {
		let t = 2 / (supply_count - 1)
		let theta = theta0 + t * (thetaV - theta0)
		let m = calc.tan(theta)
		(x0 + (y_low - y0) / m, y_low)
	}
	let as3_b = {
		let t = 2 / (supply_count - 1)
		let theta = theta0 + t * (thetaV - theta0)
		let m = calc.tan(theta)
		(x0 + (y_high - y0) / m, y_high)
	}
	let asN_a = (x0, y_low)
	let asN_b = (x0, y_high)

	let e1 = _line_intersection(as0_a, as0_b, ad1_a, ad1_b)
	let e2 = _line_intersection(as2_a, as2_b, ad1_a, ad1_b)
	let e3 = _line_intersection(as3_a, as3_b, ad1_a, ad1_b)
	let e4 = _line_intersection(asN_a, asN_b, ad1_a, ad1_b)

	// Demand-shock size (horizontal distance between DA' and DA at a fixed pi)
	let y_ref = e0.at(1)
	let theta = _point_at_y(ad1_a, ad1_b, y_ref).at(0) - _point_at_y(ad0_a, ad0_b, y_ref).at(0)

	let ys = (e0.at(0), e1.at(0), e2.at(0), e3.at(0), e4.at(0))
	let pis = (e0.at(1), e1.at(1), e2.at(1), e3.at(1), e4.at(1))
	let thetas = (0, theta, theta, theta, theta)
	let y_base = ys.at(0)
	let pi_base = pis.at(0)
	let ys = (ys.at(0) - y_base, ys.at(1) - y_base, ys.at(2) - y_base, ys.at(3) - y_base, ys.at(4) - y_base)
	let pis = (pis.at(0) - pi_base, pis.at(1) - pi_base, pis.at(2) - pi_base, pis.at(3) - pi_base, pis.at(4) - pi_base)

	let width = 6.0
	let height = 5.0
	let gap = 0.20
	let h_each = (height - 2 * gap) / 3
	let margins = (left: 0.80, right: 0.15, bottom: 0.32, top: 0.16)

	_timeseries_subplot(draw, (0, 2 * (h_each + gap)), width, h_each, ys, [$y$], xlabel: none, t_end: 8, zero_line: true, margins: margins)
	_timeseries_subplot(draw, (0, h_each + gap), width, h_each, pis, [$pi$], xlabel: none, t_end: 8, zero_line: true, margins: margins)
	_timeseries_subplot(draw, (0, 0), width, h_each, thetas, [$θ$], xlabel: [$t$], t_end: 8, zero_line: true, margins: margins)
})


// Stabilization after a negative supply shock: tradeoff between π and y
#let stabilization(length: 0.55cm) = _asad_canvas(length: length, draw => {
	let xmax = 6
	let ymax = 5

	_axes(draw, xmax, ymax, xlabel: [$y$], ylabel: [$pi$])

	// Demand (baseline) and two policy responses
	let ad0_a = (1.2, 4.6)
	let ad0_b = (5.2, 1.2)
	let adY_a = (2.1, 4.6) // stimulate to stabilize output (DA')
	let adY_b = (6.1, 1.2)
	let adPi_a = (0.6, 4.6) // tighten to stabilize inflation
	let adPi_b = (4.6, 1.2)

	// Supply shock: OA shifts left (lower y^n) -> higher π for given y
	let as0_a = (1.2, 1.0)
	let as0_b = (5.2, 4.4)
	// Choose OA' as a *left shift* of OA such that OA' ∩ DA' has the same x as the initial equilibrium.
	let e0_ref = _line_intersection(as0_a, as0_b, ad0_a, ad0_b)
	let x_ref = e0_ref.at(0)
	let m_as = (as0_b.at(1) - as0_a.at(1)) / (as0_b.at(0) - as0_a.at(0))
	let c_as = as0_a.at(1) - m_as * as0_a.at(0)
	let m_adY = (adY_b.at(1) - adY_a.at(1)) / (adY_b.at(0) - adY_a.at(0))
	let c_adY = adY_a.at(1) - m_adY * adY_a.at(0)
	let dx = (m_adY * x_ref + c_adY - (m_as * x_ref + c_as)) / m_as
	let asS_a = (as0_a.at(0) - dx, as0_a.at(1))
	let asS_b = (as0_b.at(0) - dx, as0_b.at(1))
	_curve(draw, as0_a, as0_b, [OA], label_pos: 100%, label_anchor: "south-west")
	_curve(draw, asS_a, asS_b, [OA$'$], label_pos: 100%, label_anchor: "south-west")

	// Supply shift arrow (horizontal, pointing left)
	let supply_t = 0.78
	let y_supply_arrow = as0_a.at(1) + supply_t * (as0_b.at(1) - as0_a.at(1))
	let s_from = _point_at_y(as0_a, as0_b, y_supply_arrow)
	let s_to = _point_at_y(asS_a, asS_b, y_supply_arrow)
	_arrow(draw, s_from, s_to, label: [Stabilisation], label_anchor: "south")

	_curve(draw, ad0_a, ad0_b, [DA], label_pos: 100%, label_anchor: "north-west")
	_curve(draw, adY_a, adY_b, [DA$'$], label_pos: 100%, label_anchor: "north-west")

	// Demand shift arrow (horizontal: DA -> DA', same placement as in demand_shock)
	let label_t = 0.82
	let y_arrow = ad0_a.at(1) + label_t * (ad0_b.at(1) - ad0_a.at(1))
	let shift_from = _point_at_y(ad0_a, ad0_b, y_arrow)
	let shift_to = _point_at_y(adY_a, adY_b, y_arrow)
	_arrow(draw, shift_from, shift_to, label: [Choc de Demande], label_anchor: "north")

	// Equilibria
	let e0 = e0_ref // initial
	let eS = _line_intersection(asS_a, asS_b, ad0_a, ad0_b) // after supply shock, no policy
	let eY = _line_intersection(asS_a, asS_b, adY_a, adY_b) // stabilize y (higher π)

	_eq(draw, "e0", e0, xlab: [$y$], ylab: [$pi$])
	_eq(draw, "eS", eS, xlab: [$y'$], ylab: [$pi'$])
	_eq(draw, "eY", eY)

	// Policy arrows from post-shock point
	// _arrow(draw, eS, eY, label: [stabiliser $y$], label_anchor: "south-east")
	// _arrow(draw, eS, ePi, label: [stabiliser $pi$], label_anchor: "north-east")
})


#demand_shock(length: 1.1cm)
#pagebreak()
// Side-by-side: AS/AD adjustment vs. its time-series
#grid(
	columns: (1fr, 1fr),
	gutter: 1em,
)[
	#demand_shock_adjustment(length: 1.0cm)
][
	// #demand_shock_adjustment_timeseries(length: 1.1cm)
  #demand_shock_adjustment_persistent_timeseries(length: 1.1cm)
]

#grid(
	columns: (1fr, 1fr),
	gutter: 1em,
)[
#demand_shock_adjustment_partial_reversal(length: 1.1cm)
][
#demand_shock_adjustment_partial_reversal_timeseries(length: 1.22cm)
]

#pagebreak()
#stabilization(length: 1.1cm)